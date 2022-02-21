# TCC - Client centralization service

## Start

* Running docker-compose locally:
```
docker-compose up -d
```

* Install dependencies:
```
docker-compose exec php composer install
```

* Creating database structure
```
docker-compose exec php  bin/console doctrine:migrations:migrate
```

**All commands need to be running on project folder.**