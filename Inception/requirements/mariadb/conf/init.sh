#!/bin/sh
set -eu

echo "📦 [init.sh] Iniciando inicialización de MariaDB..."

DB_PASSWORD_FILE="/run/secrets/db_password"
if [ ! -f "$DB_PASSWORD_FILE" ]; then
  echo "⛔ Secreto db_password no encontrado en $DB_PASSWORD_FILE"
  exit 1
fi

DB_PASSWORD=$(cat "$DB_PASSWORD_FILE")

cat <<EOF > /docker-entrypoint-initdb.d/init.sql
CREATE DATABASE IF NOT EXISTS \`wordpress\`;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`wordpress\`.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF

echo "✅ init.sql generado: base de datos 'wordpress' y usuario 'wp_user'"
