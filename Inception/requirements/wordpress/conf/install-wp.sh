#!/bin/bash
set -eu

echo "📦 Iniciando instalación automática de WordPress..."

# Leer variables desde el archivo de secrets
CREDENTIALS_FILE="/run/secrets/credentials"
while IFS='=' read -r key value; do
  export "$key"="$value"
  echo "✅ Variable exportada: $key=$value"
done < "$CREDENTIALS_FILE"

# Esperar a que la base de datos esté lista
until wp --allow-root --path=/var/www/html db check >/dev/null 2>&1; do
  echo "⏳ Esperando a que MariaDB esté disponible..."
  sleep 2
done

# Instalar WordPress solo si no está instalado
if wp --allow-root --path=/var/www/html core is-installed; then
  echo "✅ WordPress ya está instalado."
else
  if [ ! -f /var/www/html/index.php ]; then
    echo "📥 Descargando WordPress..."
    wp core download --allow-root --path=/var/www/html
  fi

  echo "⚙️ Generando wp-config.php con WP-CLI..."
  wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="$DB_HOST" \
    --path=/var/www/html \
    --allow-root

  echo "🚀 Ejecutando instalación de WordPress..."
  wp core install \
    --url="https://${DOMAIN_NAME}" \
    --title="Inception WP" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --path=/var/www/html \
    --skip-email \
    --allow-root

  echo "✅ WordPress instalado correctamente."
fi

exec php-fpm
