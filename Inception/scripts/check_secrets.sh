#!/bin/bash

SECRETS_DIR=./secrets

FILES=(credentials.txt db_password.txt db_root_password.txt)

echo "🔍 Comprobando archivos secretos..."

for FILE in "${FILES[@]}"; do
  if [ ! -f "$SECRETS_DIR/$FILE" ]; then
    echo "❌ Error: Falta el archivo $FILE en $SECRETS_DIR"
    exit 1
  else
    echo "✅ $FILE encontrado."
  fi
done

echo "🎉 Todos los archivos secretos están correctamente configurados."
