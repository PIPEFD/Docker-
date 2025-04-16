#!/bin/sh

HOST=${1:-wordpress}
PORT=${2:-9000}
RETRIES=30
SLEEP_TIME=2

echo "🔄 Esperando a que WordPress esté disponible en $HOST:$PORT..."

for i in $(seq 1 $RETRIES); do
    if nc -z "$HOST" "$PORT"; then
        echo "✅ WordPress disponible en intento $i"
        break
    fi
    echo "❌ WordPress no disponible aún (intento $i/$RETRIES). Esperando $SLEEP_TIME segundos..."
    sleep $SLEEP_TIME
done

if ! nc -z "$HOST" "$PORT"; then
    echo "⛔ WordPress no está disponible después de $RETRIES intentos. Arrancando Nginx igualmente."
fi

echo "🚀 Lanzando Nginx..."
exec nginx -g "daemon off;"
