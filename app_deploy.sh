#!/bin/sh

sudo chown -R vivek:vivek /var/www/html

composer install --no-dev
php artisan optimize
php artisan migrate


# Запуск приложения
supervisord -c "/etc/supervisor.d/supervisord.ini"