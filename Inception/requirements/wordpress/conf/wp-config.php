<?php
// Mostrar todos los errores de PHP
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/** Configuración de la base de datos de WordPress */
if (!defined('DB_NAME')) {
    define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress');
}
if (!defined('DB_USER')) {
    define('DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wp_user');
}
if (!defined('DB_HOST')) {
    define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb:3306');
}

// Obtener la contraseña desde Docker Secret
$db_password_file = '/run/secrets/db_password';
$db_password = file_exists($db_password_file)
    ? trim(file_get_contents($db_password_file))
    : getenv('WORDPRESS_DB_PASSWORD');

if (!defined('DB_PASSWORD')) {
    define('DB_PASSWORD', $db_password);
}

// if (!defined('DB_PORT')) {
//     define('DB_PORT', getenv('WORDPRESS_DB_PORT') ?: '3306');
// }
if (!defined('DB_CHARSET')) {
    define('DB_CHARSET', 'utf8');
}
if (!defined('DB_COLLATE')) {
    define('DB_COLLATE', '');
}

/** 🔐 Forzar dominio desde variable .env */
if (!defined('WP_HOME')) {
    define('WP_HOME', 'https://' . (getenv('DOMAIN_NAME') ?: 'localhost'));
}
if (!defined('WP_SITEURL')) {
    define('WP_SITEURL', 'https://' . (getenv('DOMAIN_NAME') ?: 'localhost'));
}

/** Depuración en WP */
if (!defined('WP_DEBUG')) {
    define('WP_DEBUG', true);
}
if (!defined('WP_DEBUG_LOG')) {
    define('WP_DEBUG_LOG', true);
}
if (!defined('WP_DEBUG_DISPLAY')) {
    define('WP_DEBUG_DISPLAY', true);
}
if (!defined('WP_HOME')) {
    define('WP_HOME', 'https://' . (getenv('DOMAIN_NAME') ?: 'localhost'));
}
if (!defined('WP_SITEURL')) {
    define('WP_SITEURL', 'https://' . (getenv('DOMAIN_NAME') ?: 'localhost'));
}

/** Claves y sales únicas */
if (!defined('AUTH_KEY'))         define('AUTH_KEY',         'clave-segura-1');
if (!defined('SECURE_AUTH_KEY'))  define('SECURE_AUTH_KEY',  'clave-segura-2');
if (!defined('LOGGED_IN_KEY'))    define('LOGGED_IN_KEY',    'clave-segura-3');
if (!defined('NONCE_KEY'))        define('NONCE_KEY',        'clave-segura-4');
if (!defined('AUTH_SALT'))        define('AUTH_SALT',        'clave-segura-5');
if (!defined('SECURE_AUTH_SALT')) define('SECURE_AUTH_SALT', 'clave-segura-6');
if (!defined('LOGGED_IN_SALT'))   define('LOGGED_IN_SALT',   'clave-segura-7');
if (!defined('NONCE_SALT'))       define('NONCE_SALT',       'clave-segura-8');

$table_prefix = 'wp_';

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
