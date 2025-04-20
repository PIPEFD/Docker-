# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:13:25 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/20 19:13:26 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM wordpress:php8.2-fpm

# Instalar utilidades de depuración y cliente MySQL
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    curl \
    less \
    net-tools \
    procps \
    default-mysql-client \
 && docker-php-ext-install mysqli \
 && rm -rf /var/lib/apt/lists/*

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configuración de PHP-FPM
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

# Script de espera para MariaDB
COPY ./wait-for-mariadb.sh /wait-for-mariadb.sh
RUN chmod +x /wait-for-mariadb.sh

# Copiar wp-config personalizado
COPY ./conf/wp-config.php /var/www/html/wp-config.php
RUN chown www-data:www-data /var/www/html/wp-config.php

# Script opcional para pruebas de conexión
COPY ./conf/check_db_connection.php /usr/local/bin/check_db_connection.php

# Asegurar permisos en la instalación
RUN chown -R www-data:www-data /var/www/html

# Entrada: espera a MariaDB antes de lanzar php-fpm
ENTRYPOINT ["/wait-for-mariadb.sh", "mariadb", "3306"]
CMD ["php-fpm"]
