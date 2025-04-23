#!/bin/bash
set -e

echo "📦 Iniciando instalación de WordPress..."

# === 1. Leer secretos ===
DB_PASSWORD_FILE="/run/secrets/db_password"
CREDENTIALS_FILE="/run/secrets/credentials"

if [ ! -f "$DB_PASSWORD_FILE" ]; then
  echo "⛔ Secreto db_password no encontrado."
  exit 1
fi

DB_PASSWORD=$(cat "$DB_PASSWORD_FILE")

if [ ! -f "$CREDENTIALS_FILE" ]; then
  echo "⛔ Secreto credentials no encontrado."
  exit 1
fi

# === 2. Exportar variables del archivo credentials ===
while IFS='=' read -r key value; do
  if [[ -n "$key" && -n "$value" ]]; then
    export "$key"="$value"
  fi
done < "$CREDENTIALS_FILE"

if [ -z "$WP_ADMIN_EMAIL" ]; then
  echo "⛔ El campo WP_ADMIN_EMAIL está vacío. Verifica tu archivo de secretos."
  exit 1
fi

echo "🔐 Variables cargadas:"
echo "  DB_NAME=$WORDPRESS_DB_NAME"
echo "  DB_USER=$WORDPRESS_DB_USER"
echo "  DB_HOST=$WORDPRESS_DB_HOST"
echo "  DOMAIN=$DOMAIN_NAME"
echo "  ADMIN_USER=$WP_ADMIN_USER"
echo "  ADMIN_EMAIL=$WP_ADMIN_EMAIL"

# === 3. Instalar WordPress si no está ===
if ! wp core is-installed --allow-root --path=/var/www/html; then
  echo "🚀 Instalando WordPress..."
  wp core install \
    --url="https://${DOMAIN_NAME}" \
    --title="Inception WP" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --path=/var/www/html \
    --skip-email \
    --allow-root || {
      echo "❌ Fallo en la instalación de WordPress.";
      exit 1;
    }
else
  echo "✅ WordPress ya estaba instalado."
fi
