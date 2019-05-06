#
#	Set up apache Webserver
#
FROM ubuntu:14.04

LABEL  key=David

RUN apt-get update
RUN apt-get -q -y install apache2 

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN mkdir -p /var/lock/apache2 /var/run/apache2

EXPOSE 80

VOLUME /var/www/html

CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

########################################################################################
# Setup simple MySQL Instance
########################################################################################

FROM ubuntu:14.04

LABEL  key=David

RUN apt-get update
RUN apt-get -q -y install mysql 

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN mkdir -p /var/lock/apache2 /var/run/apache2

# install mysql server
RUN sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
RUN	sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
RUN	sudo apt-get -y install mysql-server

#install ssh service
RUN sudo apt-get install openssh-server
RUN	sudo service ssh start

#create db directory for filesync
RUN sudo mkdir db

#install ufw
RUN	sudo apt-get install ufw -y
RUN	sudo ufw -f enable

#create rules
RUN	sudo ufw allow from any to any port 3306
RUN	sudo ufw allow from any to any port 22




EXPOSE 80

VOLUME /var/www/html

CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"