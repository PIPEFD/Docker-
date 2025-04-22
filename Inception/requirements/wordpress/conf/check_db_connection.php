<?php
$host = getenv('WORDPRESS_DB_HOST') ?: 'mariadb';
$port = getenv('WORDPRESS_DB_PORT') ?: '3306';
$user = getenv('WORDPRESS_DB_USER') ?: 'wp_user';
$dbname = getenv('WORDPRESS_DB_NAME') ?: 'wordpress';
$password = file_exists('/run/secrets/db_password')
    ? trim(file_get_contents('/run/secrets/db_password'))
    : getenv('WORDPRESS_DB_PASSWORD');

$mysqli = new mysqli($host, $user, $password, $dbname, (int)$port);

if ($mysqli->connect_error) {
    echo "❌ Error de conexión: " . $mysqli->connect_error . PHP_EOL;
    exit(1);
}

echo "✅ Conexión a la base de datos exitosa." . PHP_EOL;
$mysqli->close();
