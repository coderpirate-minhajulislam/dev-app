# Makefile for Docker Laravel setup

# Variables
DOCKER_EXEC=docker exec -it laravel_app

# Commands
build:
    docker-compose up -d --build

start:
    docker-compose up -d

stop:
    docker-compose down

bash:
    $(DOCKER_EXEC) sh

install:
    $(DOCKER_EXEC) composer install
    $(DOCKER_EXEC) npm install
    $(DOCKER_EXEC) npm run dev

migrate:
    $(DOCKER_EXEC) php artisan migrate

seed:
    $(DOCKER_EXEC) php artisan db:seed

serve:
    $(DOCKER_EXEC) php artisan serve --host=0.0.0.0 --port=8000
