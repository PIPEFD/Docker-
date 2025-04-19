<?php
// scripts/check_db_connection.php

// Obtener las variables de entorno o usar valores por defecto.
$host = getenv("WORDPRESS_DB_HOST") ?: "mariadb";
$user = getenv("WORDPRESS_DB_USER") ?: "wp_user";
$db   = getenv("WORDPRESS_DB_NAME") ?: "wordpress";

// Se define el archivo de contraseña y se utiliza su contenido si existe.
$pass_file = "/run/secrets/db_password";
$password = file_exists($pass_file) ? trim(file_get_contents($pass_file)) : getenv("WORDPRESS_DB_PASSWORD");

// Intentar conectarse a la base de datos.
$mysqli = @new mysqli($host, $user, $password, $db);

if ($mysqli->connect_error) {
    echo "❌ Conexión fallida: " . $mysqli->connect_error . PHP_EOL;
    exit(1);
} else {
    echo "✅ Conexión a la base de datos exitosa." . PHP_EOL;
}
