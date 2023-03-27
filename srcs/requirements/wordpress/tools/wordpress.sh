#!/bin/sh

while ! mysqladmin ping -h mariadb -u $WP_DB_USR -p$WP_DB_PASSWD --silent; do
	sleep 2
done

# php-fpm config
mkdir /run/php

groupadd wordpress_user
useradd -g wordpress_user wordpress_user

# Check if wordpress is already installed
if [ ! -d "/var/www/html/manmarti.42.fr" ]; then

	# Wordpress cli install
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	# Wordpress install
	mkdir wordpress
	cd wordpress
	wp core download --allow-root
	wp config create --dbhost=mariadb --dbname=$WP_DB_NAME --dbuser=$WP_DB_USR --dbpass=$WP_DB_PASSWD --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=manmarti.42.fr --title="Inception" --admin_name=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWD --admin_email=admin@gmail.com --allow-root
	wp user create $WP_USR_NAME user@example.com --user_pass=$WP_USR_PASSWD --role=author --allow-root
	cd ..
	mv wordpress /var/www/html/manmarti.42.fr
	chown -R www-data:www-data /var/www/html/manmarti.42.fr
	chmod -R 755 /var/www/html/manmarti.42.fr
fi

/usr/sbin/php-fpm7.3 -R -F
