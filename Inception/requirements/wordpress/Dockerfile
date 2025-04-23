FROM wordpress:php8.2-fpm

# Instalar WP-CLI
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# Instalar herramientas útiles
USER root
RUN apt update && apt install -y \
    iputils-ping \
    netcat-openbsd \
    mariadb-client \
    iproute2 \
    curl \
    vim \
    less \
    bash \
  && rm -rf /var/lib/apt/lists/*

# Aumentar memoria de PHP para evitar fallos en WP-CLI
COPY ./conf/php.ini /usr/local/etc/php/conf.d/memory-limit.ini

# Configuración PHP-FPM y scripts de inicialización
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/install-wp.sh /docker-entrypoint-initwp.d/install-wp.sh

# Permisos
# Permisos
RUN chmod +x /docker-entrypoint-initwp.d/install-wp.sh

# Nuevo entrypoint
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]