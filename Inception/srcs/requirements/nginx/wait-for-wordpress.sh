# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wait-for-wordpress.sh                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:13:09 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/20 19:13:10 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

HOST=${1:-wordpress}
PORT=${2:-9000}
RETRIES=30
SLEEP_TIME=2

echo "🔄 Esperando a que WordPress (php-fpm) esté disponible en $HOST:$PORT..."

for i in $(seq 1 $RETRIES); do
    if nc -z "$HOST" "$PORT"; then
        echo "✅ WordPress disponible en el intento $i"
        break
    fi
    echo "❌ WordPress aún no responde (intento $i/$RETRIES). Esperando $SLEEP_TIME segundos..."
    sleep $SLEEP_TIME
done

if ! nc -z "$HOST" "$PORT"; then
    echo "⛔ WordPress no está disponible después de $RETRIES intentos. Lanzando nginx de todas formas."
fi

echo "🚀 Iniciando Nginx..."
exec nginx -g "daemon off;"
