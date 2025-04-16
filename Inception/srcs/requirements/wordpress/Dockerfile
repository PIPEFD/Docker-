FROM wordpress:php8.2-fpm

RUN docker-php-ext-install mysqli

COPY ./conf/wp-config.php /var/www/html/wp-config.php

EXPOSE 9000
