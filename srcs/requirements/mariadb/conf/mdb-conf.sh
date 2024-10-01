#!/bin/bash

service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWD}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO \`${DB_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$DB_ROOT_PASSWD shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
