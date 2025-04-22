FROM mariadb:10.5

# Copiamos configuración y script de inicialización
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY ./conf/init.sh /docker-entrypoint-initdb.d/init.sh

# Damos permisos de ejecución al script
RUN chmod +x /docker-entrypoint-initdb.d/init.sh
