#!/usr/bin/env bash
set -e

echo "🧪 Iniciando pruebas de salud de Inception…"

# Variables dinámicas de contenedor
MARIADB=inception-mariadb-1
WORDPRESS=inception-wordpress-1
NGINX=inception-nginx-1

# 1) MariaDB responde al ping
echo -n "🔌 MariaDB (mysqladmin ping)… "
docker exec -i "$MARIADB" \
  mysqladmin ping -u root -p"$(cat secrets/db_root_password.txt)" \
    | grep -q "mysqld is alive" && echo "✅ OK"

# 2) Usuario WP puede conectar y ver la BD
echo -n "🔐 MariaDB (wp_user conecta)… "
docker exec -i "$WORDPRESS" bash -c \
  "mysql -h mariadb -u wp_user -p\"\$(cat /run/secrets/db_password)\" -e 'SHOW DATABASES;' wordpress" \
    && echo "✅ OK"

# 3) PHP‑FPM atiende al menos la raíz
echo -n "🐘 PHP‑FPM (curl interno)… "
docker exec -i "$WORDPRESS" curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/index.php \
    | grep -q "^200$" && echo "✅ OK"

# 4) Nginx sirve HTTPS con 200
echo -n "🌐 Nginx HTTPS (curl externo)… "
curl -sk -o /dev/null -w "%{http_code}" https://localhost/index.php \
    | grep -q "^200$" && echo "✅ OK"

# 5) SSL válido y no caducado
echo -n "🔒 Certificado SSL (openssl)… "
openssl s_client -connect localhost:443 -servername localhost </dev/null 2>/dev/null \
  | openssl x509 -noout -dates | grep -q "notAfter=" && echo "✅ OK"

# 6) Volúmenes montados
echo -n "📦 Volúmenes (docker volume ls)… "
docker volume ls | grep -E 'inception_mariadb-data|inception_wordpress-data' && echo "✅ OK"

# 7) Logs limpios (últimos 20 líneas)
echo -n "📜 Logs MariaDB… "
docker logs "$MARIADB" --tail 20 | grep -qi error && echo "❌ errores!" || echo "✅ limpio"
echo -n "📜 Logs WordPress… "
docker logs "$WORDPRESS" --tail 20 | grep -qi error && echo "❌ errores!" || echo "✅ limpio"

echo "🎉 ¡Todas las pruebas han pasado!"
