# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/16 08:16:10 by pipe              #+#    #+#              #
#    Updated: 2025/04/21 17:37:15 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# =====================
# Dockerfile: Nginx
# =====================

FROM debian:bullseye

# Dependencias necesarias
RUN apt update && apt install -y \
    nginx \
    netcat \
    gettext-base \
  && mkdir -p /var/log/nginx /etc/nginx/templates /run/nginx /etc/nginx/ssl /usr/share/nginx/html /etc/nginx/conf.d \
  && chown -R www-data:www-data /var/log/nginx /etc/nginx

# Copiar archivos necesarios
COPY ./conf/wait-for-wordpress.sh /wait-for-wordpress.sh
COPY ./conf/default.conf /etc/nginx/sites-available/default 
COPY ./html/error502.html /usr/share/nginx/html/error502.html
COPY ./conf/ssl /etc/nginx/ssl

# Permisos
RUN chmod +x /wait-for-wordpress.sh

# Exponer puertos
EXPOSE 443 80

# Eliminar la configuración dinámica (ya no la necesitamos)
RUN rm -f /etc/nginx/conf.d/default.conf

# Habilitar el sitio predeterminado
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Ejecutar Nginx
ENTRYPOINT ["/wait-for-wordpress.sh", "wordpress", "9000", "&&"]
CMD ["nginx", "-g", "daemon off;"]