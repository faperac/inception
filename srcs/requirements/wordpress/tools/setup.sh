#!/bin/sh

timeout=10
while ! mariadb -h mariadb -u $DB_USER -p$DB_PW -e ";"; do
	sleep 1
	timeout=$(($timeout - 1))
	if [ $timeout -eq 0 ]; then
		echo "ERROR Timeout connect to db."
		exit 1
	fi
done
echo "Mariadb ok"

if [ ! -f /var/www/html/wp-config.php ]; then
	find /var/www/html/ -type d -exec chmod 755 {} \;
	find /var/www/html/ -type f -exec chmod 644 {} \;

wp config create --dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PW \
	--dbhost=$DB_HOST \
	--dbcharset="utf8" \
	--dbprefix="wp_" \
	--allow-root
wp core install --allow-root \
	--path='/var/www/html/' \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email
wp user create --allow-root \
	--path='/var/www/html/' \
	$WP_CONTRIB_USER $WP_CONTRIB_EMAIL \
	--user_pass=$WP_CONTRIB_PASSWORD \
	--role=contributor
fi

sleep 2
echo "Wordpress ready"
php-fpm8 -F -R
