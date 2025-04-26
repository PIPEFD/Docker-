#!/bin/sh

RETRIES=10
SLEEP_TIME=2
WP_PATH="/var/www/html"

echo "🔄 Esperando a que WordPress esté listo en $WP_PATH..."

for i in $(seq 1 $RETRIES); do
    if wp core is-installed --allow-root --path=$WP_PATH > /dev/null 2>&1; then
        echo "✅ WordPress está instalado y operativo (intento $i)"
        exec nginx -g "daemon off;"
    fi
    echo "❌ WordPress aún no responde (intento $i/$RETRIES). Esperando $SLEEP_TIME segundos..."
    sleep $SLEEP_TIME
done

echo "⛔ WordPress no respondió después de $RETRIES intentos. Lanzando Nginx de todas formas."
exec nginx -g "daemon off;"
