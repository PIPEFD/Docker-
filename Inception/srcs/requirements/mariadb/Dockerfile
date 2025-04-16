FROM debian:bullseye

# Actualizar e instalar MariaDB Server
RUN apt update && apt install -y mariadb-server

# Copiar configuración personalizada (opcional)
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Crear carpeta necesaria para MariaDB
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

# Exponer el puerto por defecto de MariaDB
EXPOSE 3306

# Comando para ejecutar MariaDB de forma segura
CMD ["mysqld_safe"]
