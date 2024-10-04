#!/bin/bash

set -e

if [[ -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWD" || -z "$DB_ROOT_PASSWD" ]]; then
	echo "One or more environment variables are not defined."
	exit 1
fi

echo "Starting MariaDB..."
service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;" || {
	echo "Error creating the database.";
	exit 1;
}

mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWD}';" || {
	echo "Error creating the user.";
	exit 1;
}

mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO \`${DB_USER}\`@'%';" || {
	echo "Error granting privileges.";
	exit 1;
}

mariadb -e "FLUSH PRIVILEGES;" || {
	echo "Error flushing privileges.";
	exit 1;
}

mysqladmin -u root -p shutdown || {
	echo "Error stopping MariaDB.";
	exit 1;
}

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
