<?php

define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress');
define('DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wp_user');

$db_password_file = '/run/secrets/db_password';
$db_password = file_exists($db_password_file)
    ? trim(file_get_contents($db_password_file))
    : getenv('WORDPRESS_DB_PASSWORD');

define('DB_PASSWORD', $db_password);
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb:3306');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'm0j5U-MW|V:rb$N#wG1ZqZpE:v!r>#F/FWk.T-RRmvWzP1Z7Gts6{-+sE#GaVVG;');
define('SECURE_AUTH_KEY',  'cV16gK|aZp$3TXD~YZmHT7_GD&DZ,[Y0o+h7g%z0jv%p3^QSmQCe[Zvu4)r_!O29');
define('LOGGED_IN_KEY',    'G0Vm]Kh[1Lly>QTBmjZcv[p4]v0Kgy9tHGWfhHLY{J+I/JJ5A6#>8+d>=UgS}[z-');
define('NONCE_KEY',        'N4F!o]-A;VoT=#z(ytZ)0a>8XgoFQXn8^pV`GOv[1KH$XA^Vsc7zHR2YXgij$N,x');
define('AUTH_SALT',        'S2RU?jLtLWomzF1Ig<Q@[D#-Rrh`_Z>L4(:W60d$V*6HRHoav2mSBR[[wNS7)2K^');
define('SECURE_AUTH_SALT', 'FZCk|BpmO!Etn-mHf.Q3[:MR&_Ac%9nK1e=gZpZ93B%7.GnhdjNMR+jzX#-w_3{K');
define('LOGGED_IN_SALT',   '0)43}~-.<%5Yo<`|;ZHP,4jzr_[(G}K<qZRYUjmS$e-V;u!W:1+;*W5,nl@)3[25');
define('NONCE_SALT',       '2H##Ay+1|RJo>>vYYoYjw4O9P!`R}t%v4vV)Ej1!@-@K9DR5`7$A-3Fq5TCkpYGl');

$table_prefix = 'wp_';
define('WP_DEBUG', false);

if ( ! defined('ABSPATH') ) {
    define('ABSPATH', __DIR__ . '/');
}

if ( file_exists(ABSPATH . 'wp-settings.php') ) {
    require_once ABSPATH . 'wp-settings.php';
}
