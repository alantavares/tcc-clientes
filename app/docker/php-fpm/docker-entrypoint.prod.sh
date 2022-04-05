#!/usr/bin/env ash
set -eu

echo "Running $INFRA_ENVIRONMENT entrypoint..."
chown -R www-data:www-data /app/var

if [ "$SYMFONY_DECRYPTION_SECRET" != "" ]
then
    echo "- Writing all the decrypted secrets into the .env.$INFRA_ENVIRONMENT.local (To improve performance)..."
    /app/bin/console secrets:decrypt-to-local --force --env=$INFRA_ENVIRONMENT -vvv

    if [ "$INFRA_ENVIRONMENT" != "prod" ]
    then
        mv /app/.env.$INFRA_ENVIRONMENT.local /app/.env.prod.local
    fi
    echo "- Done"
else
    # If running via docker-compose, then it is necessary to wait for the mysql container to be available
#    echo "- Installing mysql-client..."
#    apk add --no-cache mysql-client
#    echo "- Done"

#    echo "- Waiting for mysql in host '$DB_SERVER'"
#    until mysql -u $DB_USER -p$DB_PASSWORD -h $DB_SERVER --port=$DB_PORT -e "exit" >&2
#    do
#        echo "-- MySQL is unavailable - sleeping"
#        sleep 1
#    done
    echo "- Done! MySQL is up - executing command"
fi

echo "- Resolving environment variables..."
if [ "$INFRA_ENVIRONMENT" != "prod" ]
then
	composer dump-autoload
else
	composer dump-autoload --no-dev --classmap-authoritative
fi
echo "- Done"

echo "- Warming up the Symfony cache..."
chmod 766 /app/bin/console
/app/bin/console cache:warmup --env=$INFRA_ENVIRONMENT
echo "- Done"

if [ "$INFRA_ENVIRONMENT" == "prod" ]
then
    echo "- Running migrations"
    /app/bin/console doctrine:migrations:migrate -n
    echo "- Done"
fi

echo "Done entrypoint!"

exec "$@"