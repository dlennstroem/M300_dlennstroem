#	Create MySQL-Container

FROM ubuntu:14.04
LABEL Dave M300 

# Install package & Set PWs
RUN echo 'mysql-server mysql-server/root_password password Password123' | debconf-set-selections 
RUN echo 'mysql-server mysql-server/root_password_again password Password123' | debconf-set-selections 
RUN apt-get update && apt-get install -y mysql-server 

# open Ports for MySQL
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

EXPOSE 3306
VOLUME /var/lib/mysql
CMD ["mysqld"]
