#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASS=$(cat /run/secrets/credentials)
DB_HOST=${DB_HOST:-mariadb}

mkdir -p /var/www/wordpress
cd /var/www/wordpress

echo "Attente de MariaDB sur ${DB_HOST}:3306..."
while ! bash -c "echo > /dev/tcp/${DB_HOST}/3306" 2>/dev/null; do
    sleep 2
done
echo "MariaDB est prête et accessible !"

if [ ! -f wp-config.php ]; then
    
    wp core download --allow-root --force

    wp config create \
        --allow-root \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${DB_PASS} \
        --dbhost=${DB_HOST}:3306

    wp core install \
        --allow-root \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL}

    wp user create \
        --allow-root \
        ${WP_USER} ${WP_USER_EMAIL} \
        --role=editor \
        --user_pass=${WP_ADMIN_PASS}

    echo "WordPress installé avec succès !"
fi

chown -R www-data:www-data /var/www/wordpress

mkdir -p /run/php

exec /usr/sbin/php-fpm8.2 -F
