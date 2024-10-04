#!/bin/bash

set -e

if [[ -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWD" || -z "$DOMAIN_NAME" || -z "$WP_TITLE" || -z "$WP_ADMIN_N" || -z "$WP_ADMIN_P" || -z "$WP_ADMIN_E" || -z "$WP_U_NAME" || -z "$WP_U_EMAIL" || -z "$WP_U_PASSWD" || -z "$WP_U_ROLE" ]]; then
	echo "One or more environment variables are not defined."
	exit 1
fi

if ! curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; then
	echo "WP-CLI download failed."
	exit 1
fi

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress

ping_mariadb_container() {
	nc -zv mariadb 3306 > /dev/null
	return $?
}

start_time=$(date +%s)
end_time=$((start_time + 30))
while [ $(date +%s) -lt $end_time ]; do
	ping_mariadb_container
	if [ $? -eq 0 ]; then
		echo "MariaDB is up and running."
		break
	else
		echo "Waiting for MariaDB to start..."
		sleep 1
	fi
done

if [ $(date +%s) -ge $end_time ]; then
	echo "MariaDB is not responding."
	exit 1
fi

wp core download --allow-root
wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWD" --allow-root
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASSWD" --role="$WP_U_ROLE" --allow-root

if grep -q '/run/php/php7.4-fpm.sock' /etc/php/7.4/fpm/pool.d/www.conf; then
	sed -i 's@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
fi

mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
