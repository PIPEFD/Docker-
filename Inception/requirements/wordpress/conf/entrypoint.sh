#!/bin/bash
set -e

echo "🚀 Ejecutando entrypoint.sh para WordPress..."

# === Esperar conexión a MariaDB vía script PHP ===
until php /docker-entrypoint-initwp.d/check_db_connection.php; do
  echo "⏳ Esperando a MariaDB..."
  sleep 2
done

# === Descargar WordPress si no está ===
if [ ! -f /var/www/html/index.php ]; then
  echo "📥 Descargando WordPress..."
  wp core download --path=/var/www/html --allow-root
fi

# === Copiar wp-config.php si no existe ===
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "📄 Copiando wp-config.php..."
  cp /docker-entrypoint-initwp.d/wp-config.php /var/www/html/
fi

# === Verificar que WordPress se pueda conectar a la base de datos ===
until wp db check --allow-root --path=/var/www/html >/dev/null 2>&1; do
  echo "⏳ Esperando a que WordPress se conecte con MariaDB..."
  sleep 2
done

# === Ejecutar instalación personalizada ===
/docker-entrypoint-initwp.d/install-wp.sh

# === Iniciar PHP-FPM ===
exec php-fpm
