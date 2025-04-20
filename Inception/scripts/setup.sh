# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dbonilla <dbonilla@student.42urduliz.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/20 19:11:49 by dbonilla          #+#    #+#              #
#    Updated: 2025/04/20 19:11:50 by dbonilla         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

echo "🔧 Añadiendo alias 'dockport' a ~/.bashrc..."

if ! grep -q "alias dockport=" ~/.bashrc; then
  echo "alias dockport='docker exec -it \$(docker ps -qf \"name=wordpress\") netstat -tulpn | grep 9000'" >> ~/.bashrc
  echo "✅ Alias añadido. Usa 'dockport' para verificar el puerto 9000 de WordPress."
else
  echo "⚠️ El alias 'dockport' ya existe."
fi
