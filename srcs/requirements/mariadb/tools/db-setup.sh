#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

mysqld_safe --skip-networking &
MYSQL_PID=$!

echo "Attente de MariaDB..."
until mysqladmin ping --silent 2>/dev/null; do
    sleep 1
done
echo "MariaDB est pret !"

mysql -u root << SQL
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
FLUSH PRIVILEGES;
SQL

mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown
wait $MYSQL_PID
exec mysqld_safe --user=mysql
