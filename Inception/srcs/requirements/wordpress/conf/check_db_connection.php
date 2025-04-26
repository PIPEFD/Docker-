<?php
$hostEnv = getenv('WORDPRESS_DB_HOST') ?: 'mariadb:3306';
list($host, $port) = explode(':', $hostEnv) + [null, '3306'];
$user = getenv('WORDPRESS_DB_USER') ?: 'wp_user';
$dbname = getenv('WORDPRESS_DB_NAME') ?: 'wordpress';
$password = file_exists('/run/secrets/db_password')
    ? trim(file_get_contents('/run/secrets/db_password'))
    : getenv('WORDPRESS_DB_PASSWORD');

echo "🔍 Intentando conectar con los siguientes parámetros:" . PHP_EOL;
echo "Host: $host" . PHP_EOL;
echo "Puerto: $port" . PHP_EOL;
echo "Usuario: $user" . PHP_EOL;
echo "Base de datos: $dbname" . PHP_EOL;
echo "Contraseña: " . ($password ? '***' : '[vacía]') . PHP_EOL;

$mysqli = new mysqli($host, $user, $password, $dbname, (int)$port);

if ($mysqli->connect_error) {
    echo "❌ Error de conexión: " . $mysqli->connect_error . PHP_EOL;
    exit(1);
}

echo "✅ Conexión a la base de datos exitosa." . PHP_EOL;
$mysqli->close();
