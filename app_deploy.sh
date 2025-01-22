#!/bin/sh

#curl -sS https://getcomposer.org/installer | php82 -- --install-dir=/usr/local/bin --filename=composer
#PATH="$PATH:/usr/local/bin"
composer update
composer install --cache-dir=/var/www/cache
# Обновление cache приложения
php artisan optimize

# Запуск приложения
supervisord -c  "/etc/supervisor/conf.d/supervisord.conf" && php-fpm -D &&  nginx -g "daemon off;"