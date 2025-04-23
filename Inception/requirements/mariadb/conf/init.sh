#!/bin/bash

DB_PASSWORD_FILE="/run/secrets/db_password"
ROOT_PASSWORD_FILE="/run/secrets/db_root_password"

DB_PASSWORD=$(cat "$DB_PASSWORD_FILE")
ROOT_PASSWORD=$(cat "$ROOT_PASSWORD_FILE")

echo "🔐 Inicializando base de datos y usuario 'wp_user'..."

mysql -u root -p"$ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS \`wordpress\`;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`wordpress\`.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF