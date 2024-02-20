#!/bin/sh

sed -i "s/data_base_name_here/$DB_NAME/g" /var/www/wp-config.php

sed -i "s/username_here/$DB_USER/g" /var/www/wp-config.php

sed -i "s/password_here/$DB_PASSWORD/g" /var/www/wp-config.php

chmod -R 777 /var/www/*

php-fpm8 -F
