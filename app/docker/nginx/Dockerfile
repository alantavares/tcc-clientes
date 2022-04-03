FROM nginx:1.17.10-alpine

COPY docker/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template

COPY docker/nginx/docker-entrypoint.prod.sh /docker-entrypoint.sh

COPY ./public /var/www/app/public

RUN chmod +x /docker-entrypoint.sh

ARG API_HOST
ARG API_PORT

ENV API_HOST $API_HOST
ENV API_PORT $API_PORT

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]