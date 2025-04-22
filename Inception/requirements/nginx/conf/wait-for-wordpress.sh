#!/bin/sh

HOST=${1:-wordpress}
PORT=${2:-9000}
RETRIES=10
SLEEP_TIME=2

echo "🔄 Esperando a que WordPress esté disponible en $HOST:$PORT..."

for i in $(seq 1 $RETRIES); do
    if curl -s "http://$HOST:$PORT" | grep -q "WordPress"; then
        echo "✅ WordPress respondió correctamente en el intento $i"
        exec nginx -g "daemon off;"
    fi
    echo "❌ WordPress aún no responde (intento $i/$RETRIES). Esperando $SLEEP_TIME segundos..."
    sleep $SLEEP_TIME
done

echo "⛔ WordPress no respondió después de $RETRIES intentos. Lanzando Nginx de todas formas."
exec nginx -g "daemon off;"
