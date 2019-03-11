#!/bin/bash
#
#	Install and configure DB

# Set root-pw
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password S3cr3tp4ssw0rd'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password S3cr3tp4ssw0rd'

# Installation
sudo apt-get install -y mysql-server

# Open DB-Port
sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

mysql -uroot -pS3cr3tp4ssw0rd <<%EOF%
	CREATE USER 'root'@'192.168.0.101' IDENTIFIED BY 'password';
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.0.101';
	FLUSH PRIVILEGES;
%EOF%

sudo service mysql restart