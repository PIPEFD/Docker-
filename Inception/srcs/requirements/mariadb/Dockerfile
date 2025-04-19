FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/conf.d/custom.cnf
COPY ./conf/init.sh /docker-entrypoint-initdb.d/init.sh

RUN mkdir -p /var/run/mysqld \
 && chown -R mysql:mysql /var/run/mysqld \
 && chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

USER mysql
ENTRYPOINT ["mysqld"]
