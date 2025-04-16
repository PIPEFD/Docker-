FROM debian:bullseye

# Instalar nginx, openssl y netcat para hacer el wait
RUN apt update && apt install -y nginx openssl netcat && \
    mkdir -p /var/log/nginx /etc/nginx/conf.d /run/nginx /etc/nginx/ssl /usr/share/nginx/html

# Establecer permisos
RUN chown -R www-data:www-data /var/log/nginx /etc/nginx

# Copiar script wait-for-wordpress y dar permisos
COPY ./wait-for-wordpress.sh /wait-for-wordpress.sh
RUN chmod +x /wait-for-wordpress.sh

# Copiar archivo de configuración de nginx
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Copiar HTML personalizado de error
COPY ./html/error502.html /usr/share/nginx/html/error502.html

# Crear certificado SSL autofirmado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=ES/ST=42/L=Inception/O=42/OU=Student/CN=localhost"

# Exponer el puerto HTTPS
EXPOSE 443

# Usar script como punto de entrada (espera + nginx)
ENTRYPOINT ["/wait-for-wordpress.sh"]
