# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    check_env.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:09:02 by pipe              #+#    #+#              #
#    Updated: 2025/04/20 19:11:11 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Verifica que Docker esté corriendo
echo "🔍 Verificando Docker..."
if ! docker info >/dev/null 2>&1; then
  echo "❌ Docker no está ejecutándose. ¡Inícialo primero!"
  exit 1
fi
echo "✅ Docker está corriendo."

# Verifica si la red inception_network existe, si no, la crea
NETWORK_NAME="inception_network"

echo "🔍 Verificando red Docker '$NETWORK_NAME'..."
if ! docker network ls | grep "$NETWORK_NAME" >/dev/null; then
  echo "⚙️ Creando red Docker: $NETWORK_NAME"
  docker network create "$NETWORK_NAME"
  echo "✅ Red Docker '$NETWORK_NAME' creada."
else
  echo "✅ Red Docker '$NETWORK_NAME' ya existe."
fi
