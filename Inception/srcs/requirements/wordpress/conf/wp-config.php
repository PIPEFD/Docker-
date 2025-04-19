<?php
// Mostrar todos los errores de PHP
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/** Configuración de la base de datos de WordPress */
define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress');
define('DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wp_user');

// Obtener la contraseña desde Docker Secret
$db_password_file = '/run/secrets/db_password';
$db_password = file_exists($db_password_file)
    ? trim(file_get_contents($db_password_file))
    : getenv('WORDPRESS_DB_PASSWORD');

define('DB_PASSWORD', $db_password);

define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb');
define('DB_PORT', getenv('WORDPRESS_DB_PORT') ?: '3306');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

/** Depuración en WP */
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);

/** Claves y sales únicas */
define('AUTH_KEY',         'clave-segura-1');
define('SECURE_AUTH_KEY',  'clave-segura-2');
define('LOGGED_IN_KEY',    'clave-segura-3');
define('NONCE_KEY',        'clave-segura-4');
define('AUTH_SALT',        'clave-segura-5');
define('SECURE_AUTH_SALT', 'clave-segura-6');
define('LOGGED_IN_SALT',   'clave-segura-7');
define('NONCE_SALT',       'clave-segura-8');

$table_prefix = 'wp_';

if ( ! defined('ABSPATH') ) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
