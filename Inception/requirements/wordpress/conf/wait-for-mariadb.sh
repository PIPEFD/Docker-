#!/bin/bash

# Esperar a que MariaDB esté lista (vía PHP check propio)
until php /check_db_connection.php; do
  echo "⏳ Esperando a MariaDB..."
  sleep 2
done

# Copiar wp-config.php si no existe
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "📄 Copiando wp-config.php..."
  cp /docker-entrypoint-initwp.d/wp-config.php /var/www/html/
fi

# ⚠️ Ahora que wp-config.php existe, puedes usar wp db check
until wp db check --allow-root >/dev/null 2>&1; do
  echo "⏳ Esperando a que WordPress se conecte con MariaDB..."
  sleep 2
done

# Ejecutar instalación automática
/install-wp.sh

# Lanzar PHP-FPM
exec php-fpm
