#!/bin/sh
mysql_install_db --basedir=/usr --datadir=/srv/mysql --user=mysql
chown -R mysql:mysql /srv/mysql

install -v -m755 -o mysql -g mysql -d /run/mysqld
mysqld_safe --user=mysql 2>&1 >/dev/null

mysqladmin -u root password

mysqladmin -p shutdown

rm /etc/mysql/my.cnf.spkgnew

scratch install -y mariadb-boot
