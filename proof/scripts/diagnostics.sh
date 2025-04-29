#!/bin/sh

# ============================
# Esperar a que MariaDB esté disponible
# ============================

HOST=${1:-mariadb}
PORT=${2:-3306}
RETRIES=30
SLEEP_TIME=2

# Comando por defecto a ejecutar tras la espera
shift 2
CMD=${@:-php-fpm}

echo "🔄 Esperando a que MariaDB esté completamente disponible en $HOST:$PORT..."

for i in $(seq 1 $RETRIES); do
    if mysqladmin ping -h"$HOST" --silent; then
        echo "✅ MariaDB disponible en el intento $i"
        break
    fi
    echo "❌ MariaDB aún no responde (intento $i/$RETRIES)..."
    sleep $SLEEP_TIME
done

if ! mysqladmin ping -h"$HOST" --silent; then
    echo "⛔ MariaDB no está disponible después de $RETRIES intentos. Abortando."
    exit 1
fi

# ============================
# Copiar WordPress si no está completo
# ============================

if [ ! -e /var/www/html/wp-settings.php ] || [ ! -e /var/www/html/index.php ]; then
    echo "📦 WordPress incompleto o no detectado. Copiando desde /usr/src/wordpress..."
    cp -r /usr/src/wordpress/* /var/www/html/
    cp -r /usr/src/wordpress/. /var/www/html/
    chown -R www-data:www-data /var/www/html
else
    echo "✅ WordPress ya presente en /var/www/html"
fi

# ============================
# Validar configuración personalizada
# ============================

if [ -f /docker-entrypoint-initwp.d/wp-config.php ]; then
    echo "📦 Copiando wp-config.php personalizado..."
    cp /docker-entrypoint-initwp.d/wp-config.php /var/www/html/wp-config.php
    chown www-data:www-data /var/www/html/wp-config.php
else
    echo "⚠️  wp-config.php no encontrado en /docker-entrypoint-initwp.d/"
fi

# ============================
# Lanzar PHP-FPM (o cualquier CMD)
# ============================

echo "🚀 Lanzando WordPress (comando: $CMD)"
exec $CMD
