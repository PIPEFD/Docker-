# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/26 21:22:44 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/26 23:29:38 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# =====================
# Dockerfile: Wordpress
# =====================

FROM debian:bullseye

# Variables de entorno
# ENV DEBIAN_FRONTEND=noninteractive

# Instalar PHP-FPM 7.4 + extensiones necesarias + herramientas de red
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-gd \
    php7.4-curl \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-cli \
    mariadb-client \
    curl \
    netcat-openbsd \
    iputils-ping \
    iproute2 \
    less \
    vim \
    bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar WP-CLI
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# Crear carpetas necesarias
RUN mkdir -p /var/www/html /docker-entrypoint-initwp.d

# Copiar configuraciones y scripts
COPY ./conf/php.ini /etc/php/7.4/fpm/conf.d/99-custom.ini
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/install-wp.sh /docker-entrypoint-initwp.d/install-wp.sh
COPY ./conf/entrypoint.sh /entrypoint.sh
COPY ./conf/check_db_connection.php /docker-entrypoint-initwp.d/check_db_connection.php
COPY ./conf/wp-config.php /docker-entrypoint-initwp.d/wp-config.php

# Permisos
RUN chmod +x /docker-entrypoint-initwp.d/install-wp.sh /entrypoint.sh

# Exponer puerto de PHP-FPM
EXPOSE 9000

# Definir entrypoint
ENTRYPOINT ["/entrypoint.sh"]
