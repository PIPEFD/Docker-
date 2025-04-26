#!/bin/bash
set -e

# Leer secrets
DB_PASS_FILE="/run/secrets/db_password"
ROOT_PASS_FILE="/run/secrets/db_root_password"
for f in "$DB_PASS_FILE" "$ROOT_PASS_FILE"; do
  [[ -f "$f" ]] || { echo "❌ Falta $f"; exit 1; }
done
DB_PASSWORD=$(<"$DB_PASS_FILE")
ROOT_PASSWORD=$(<"$ROOT_PASS_FILE")

echo "🚀 Preparando MariaDB..."

# 1) Inicializar datos si es el primer arranque
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "📦 Inicializando la base de datos de MariaDB..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# 2) Generar el script SQL de inicialización
INIT_SQL="/init.sql"
cat > "$INIT_SQL" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`wordpress\`;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`wordpress\`.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF

chmod 644 "$INIT_SQL"

echo "🚀 Arrancando MariaDB con init-file..."
exec /usr/sbin/mysqld \
  --socket=/run/mysqld/mysqld.sock \
  --datadir=/var/lib/mysql \
  --init-file="$INIT_SQL"
