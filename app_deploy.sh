#!/bin/sh

#chown -R vivek:vivek /var/www/html

composer install --no-dev
#composer install
php artisan key:generate
php artisan optimize
php artisan make:queue-table
php artisan migrate

#Генерация класса задания - команда поместит новый класс задания в каталог app/Jobs вашего приложения.
#php artisan make:job ProcessPodcast
#php artisan make:job ProcessSendingEmail

# Запуск приложения
supervisord -c "/etc/supervisor.d/supervisord.ini"