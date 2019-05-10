#install ufw
sudo apt-get install ufw -y
sudo ufw -f enable

#create rules
#sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 3306/tcp
sudo ufw allow from 192.168.55.1 to any port 22
