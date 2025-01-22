#!/bin/bash
composer install
npm install && npm run build
php artisan migrate
php-fpm -F &
nginx -g "daemon off;"
