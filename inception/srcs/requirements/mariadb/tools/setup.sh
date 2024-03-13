#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

echo "chown ok"

mysql_install_db --user=mysql --datadir=/var/lib/mysql

echo "mysql_install_db ok"

/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &

while ! /usr/bin/mysqladmin ping --silent ; do
	echo "mysql connecting ..."
	sleep 1
done

mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "CREATE DATABASE ${DB_NAME};"
mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFY BY '${DB_PW}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

/usr/bin/mysqld_safe --datadir=/var/lib/mysql
