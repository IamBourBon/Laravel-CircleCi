FROM composer:latest as build

WORKDIR /app

ADD composer.json composer.lock ./

RUN composer install --no-scripts --no-dev --no-autoloader --prefer-dist --no-interaction

RUN composer dump-autoload --no-scripts --no-dev --optimize

COPY . /app


FROM php:8.2.0-apache

COPY --from=build /app /var/www/html

RUN chown -R www-data:www-data /var/www/html/*