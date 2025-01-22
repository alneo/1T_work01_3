ARG FOO=bar
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y nginx

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl \
    unzip \
    git \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev  \
    nodejs \
    npm \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pgsql pdo_pgsql pdo_mysql mbstring exif pcntl bcmath gd zip intl opcache

COPY ./php.ini /usr/local/etc/php
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="$PATH:/usr/local/bin"
#COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chown -R www-data:www-data /var/lib/nginx
RUN chown -R www-data:www-data /run

ARG FOO=10
WORKDIR /var/www/html

#RUN composer create-project --prefer-dist laravel/laravel=^11.0 ./
#RUN composer install

#COPY ./.env /var/www/html/.env
RUN chown -R www-data:www-data /var/www

# Была ошибка curl error 28 while downloading https://repo.packagist.org/p2/laravel/ui.json: Connection timed out after 10006 milliseconds
#RUN composer self-update
#RUN composer require laravel/ui --dev
#RUN php artisan ui bootstrap --auth
#RUN php artisan config:cache
#RUN php artisan route:cache
#RUN php artisan view:cache

#RUN npm install && npm run build

ADD init.sh /
RUN chmod +x /init.sh
USER www-data
CMD ["/init.sh"]