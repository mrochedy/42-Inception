#!/bin/bash

set -e

if [[ -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWD" || -z "$DOMAIN_NAME" || -z "$WP_TITLE" || -z "$WP_A_NAME" || -z "$WP_A_PASSWD" || -z "$WP_A_EMAIL" || -z "$WP_U_NAME" || -z "$WP_U_EMAIL" || -z "$WP_U_PASSWD" || -z "$WP_U_ROLE" ]]; then
	echo "One or more environment variables are not defined."
	exit 1
fi

if ! curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; then
	echo "WP-CLI download failed."
	exit 1
fi

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/web
chmod -R 755 .
chown -R www-data:www-data .

start_time=$(date +%s)
end_time=$((start_time + 60))
while [ $(date +%s) -lt $end_time ]; do
	nc -zv mariadb 3306 > /dev/null
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

if [ ! -f /var/www/web/wp-load.php ]; then
	wp core download --allow-root
	wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWD" --allow-root
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_A_NAME" --admin_password="$WP_A_PASSWD" --admin_email="$WP_A_EMAIL" --allow-root
	wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASSWD" --role="$WP_U_ROLE" --allow-root
else
	echo "WordPress files already exist, skipping wordpress config."
fi

if ! wp plugin is-installed redis-cache --allow-root; then
	wp plugin install redis-cache --activate --allow-root
else
	echo "Redis plugin is already installed."
	if ! wp plugin is-active redis-cache --allow-root; then
		wp plugin activate redis-cache --allow-root
	else
		echo "Redis plugin is already activated."
	fi
fi

wp config set WP_REDIS_HOST "redis" --allow-root
wp redis enable --allow-root

sed -i 's@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
