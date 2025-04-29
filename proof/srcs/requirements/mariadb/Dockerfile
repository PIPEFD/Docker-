# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/26 21:22:57 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/26 21:23:20 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# =====================
# Dockerfile: MariaDB
# =====================

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    mkdir -p /run/mysqld && chmod 777 /run/mysqld && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY conf/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
