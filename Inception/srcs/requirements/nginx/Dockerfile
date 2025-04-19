# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pipe <pipe@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/16 08:16:10 by pipe              #+#    #+#              #
#    Updated: 2025/04/19 19:52:26 by pipe             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# =====================
# Dockerfile: Nginx
# =====================

FROM debian:bullseye

# Dependencias necesarias
RUN apt update && apt install -y \
    nginx \
    openssl \
    netcat \
 && mkdir -p /var/log/nginx /etc/nginx/conf.d /run/nginx /etc/nginx/ssl /usr/share/nginx/html \
 && chown -R www-data:www-data /var/log/nginx /etc/nginx

# Copiar scripts y archivos de configuración
COPY ./wait-for-wordpress.sh /wait-for-wordpress.sh
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./html/error502.html /usr/share/nginx/html/error502.html

# Dar permisos al script
RUN chmod +x /wait-for-wordpress.sh

# Generar certificado SSL autofirmado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=ES/ST=42/L=Inception/O=42/OU=Student/CN=localhost"

# (Opcional) Validación del certificado (útil en desarrollo/debug)
# RUN openssl x509 -in /etc/nginx/ssl/nginx.crt -text -noout

# Exponer puerto HTTPS
EXPOSE 443

# Script de entrada
ENTRYPOINT ["/wait-for-wordpress.sh"]
