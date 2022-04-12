FROM php:8.0-fpm-alpine AS base

ARG APP_ENV
ARG APP_DEBUG
ARG APP_SECRET
ARG APP_URL
ARG EXCEPTION_LISTENER_MODE
ARG INFRA_ENVIRONMENT
ARG SYMFONY_DECRYPTION_SECRET
ARG DATABASE_URL
ARG KAFKA_URL
ARG S3_BUCKET

ENV APP_ENV $APP_ENV
ENV APP_DEBUG $APP_DEBUG
ENV APP_SECRET $APP_SECRET
ENV APP_URL $APP_URL
ENV EXCEPTION_LISTENER_MODE $EXCEPTION_LISTENER_MODE
ENV INFRA_ENVIRONMENT $INFRA_ENVIRONMENT
ENV SYMFONY_DECRYPTION_SECRET $SYMFONY_DECRYPTION_SECRET
ENV DATABASE_URL $DATABASE_URL
ENV KAFKA_URL $KAFKA_URL
ENV S3_BUCKET $S3_BUCKET

ENV COMPOSER_ALLOW_SUPERUSER="1"
ENV PATH="/app/bin:/app/vendor/bin:${PATH}"

ARG DEPLOY_CMD=php-fpm
ENV DEPLOY_CMD $DEPLOY_CMD

# add virtual build dependencies
RUN apk add --no-cache --virtual build-deps bash make wget git gcc g++ autoconf

# rdkafka dependencies 
RUN apk add --no-cache musl-dev zlib-dev openssl zstd-dev pkgconfig libc-dev \
    && wget https://github.com/edenhill/librdkafka/archive/refs/tags/v1.6.2.tar.gz \
    && tar -xvf v1.6.2.tar.gz \
    && cd librdkafka-1.6.2 \
    && ./configure --prefix /usr \
    && make \
    && make install

# Parquet dependencies
RUN git clone --recursive --depth=1 https://github.com/kjdev/php-ext-snappy.git \
    && cd php-ext-snappy \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable snappy \
    && apk add gmp-dev \
    && docker-php-ext-install gmp \
    && docker-php-ext-install bcmath

# Enable kafka connection dependecy
RUN docker-php-ext-install pdo_mysql \
    && apk add build-base \
    && pecl install rdkafka-6.0.1 \
    && docker-php-ext-enable rdkafka

# removing build dependencies
RUN apk del build-deps

COPY --from=composer:2.3 /usr/bin/composer /usr/bin/composer
RUN true
COPY ./ /app
RUN true
COPY ./composer.json  /app/composer.json
RUN true
COPY ./composer.lock  /app/composer.lock
RUN true
COPY ./docker/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf
RUN true
COPY ./bin       /app/bin
RUN true
COPY ./config    /app/config
RUN true
COPY ./public    /app/public
RUN true
COPY ./src       /app/src

WORKDIR /app

RUN mkdir -p /app/var/ \
    && mkdir -p /app/var/cache \
    && mkdir -p /app/var/log \
    && chmod -R 777 /app/var/ \
    && chown -R www-data:www-data /app/var \
    && chmod +x /app/bin/console

RUN apk add --no-cache --virtual .build-deps \
    g++ make autoconf \
    && rm -rf /tmp/pear

EXPOSE 9000

FROM base AS dev

ENV WAIT_VERSION 2.9.0
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

RUN echo "Symfony dependency: PHP intl extension." \
    && apk add --no-cache icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-3.0.0 \
    && docker-php-ext-enable xdebug

COPY docker/php-fpm/php.dev.ini /usr/local/etc/php/php.ini

CMD /wait && ${DEPLOY_CMD}

FROM base AS prod

COPY docker/php-fpm/php.prod.ini /usr/local/etc/php/php.ini
RUN true
COPY docker/php-fpm/docker-entrypoint.prod.sh /usr/local/bin/docker-entrypoint.sh
RUN true
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions intl mysqli opcache

RUN composer install \
    --no-dev --optimize-autoloader \
    --no-ansi --no-interaction --no-progress --no-scripts --no-suggest

RUN mkdir -p /app/var/ \
    && mkdir -p /app/var/cache \
    && mkdir -p /app/var/log \
    && chmod -R 777 /app/var/ \
    && chown -R www-data:www-data /app/var \
    && chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /app/bin/console

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]
CMD ${DEPLOY_CMD}