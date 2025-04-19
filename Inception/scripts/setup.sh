#!/bin/bash

echo "🔧 Añadiendo alias 'dockport' a ~/.bashrc..."

if ! grep -q "alias dockport=" ~/.bashrc; then
  echo "alias dockport='docker exec -it \$(docker ps -qf \"name=wordpress\") netstat -tulpn | grep 9000'" >> ~/.bashrc
  echo "✅ Alias añadido. Usa 'dockport' para verificar el puerto 9000 de WordPress."
else
  echo "⚠️ El alias 'dockport' ya existe."
fi
