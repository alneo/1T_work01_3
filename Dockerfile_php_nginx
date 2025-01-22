FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
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
    && docker-php-ext-install pdo pgsql pdo_pgsql pdo_mysql mbstring exif pcntl bcmath gd zip intl opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./confs/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./confs/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./confs/php.ini /usr/local/etc/php
RUN chown -R www-data:www-data /var/lib/nginx
RUN chown -R www-data:www-data /run
RUN chown -R www-data:www-data /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="$PATH:/usr/local/bin"

WORKDIR /var/www/html

ADD ./confs/init.sh /
RUN chmod +x /init.sh
USER www-data
CMD ["/init.sh"]