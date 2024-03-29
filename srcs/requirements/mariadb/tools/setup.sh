#!/bin/sh

# Assign the ownership of the directory to the MySQL user and group
chown -R mysql:mysql /var/lib/mysql

# Initialize MySQL database
mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

# Start MySQL in the background
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# Wait until the MySQL server is available
while ! /usr/bin/mysqladmin ping --silent; do
	echo "connect to db..."
	sleep 1
done

# Cleaning the database
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -e "DELETE FROM mysql.db WHERE Db='test';"
# Inserting the data into the database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PW';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

# Shutdown MySQL in the background
mysqladmin shutdown

# Start MySQL in the foreground
/usr/bin/mysqld_safe --datadir=/var/lib/mysql
