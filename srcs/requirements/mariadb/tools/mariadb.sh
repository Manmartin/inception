#!/bin/sh

# Ensure allow remote conections
echo "[server]\nskip-networking=0" >> /etc/mysql/conf.d/mysql.cnf 
sed -i 's/bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf


# Init mariadb service
/etc/init.d/mysql start


# Manually mysql_secure_intallation
# 1. Change root password
# 2. Remove anonymous users
# 3. Remove root remote access

# Create an admin for wordpress

if [ ! -d "/var/lib/mysql/$WP_DB_NAME" ]; then
	mariadb -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY "$MARIADB_ROOT_PASSWD";
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
CREATE DATABASE $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER "$WP_DB_USR"@"%" IDENTIFIED BY "$WP_DB_PASSWD";
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO "$WP_DB_USR"@"%" IDENTIFIED BY "$WP_DB_PASSWD";
FLUSH PRIVILEGES;
EXIT;
EOF

fi

exec mysqld
