#!/bin/bash

mysql_apt_deb=mysql-apt-config_0.8.15-1_all.deb
sudo apt-get remove mysql-server mysql-client -y
sudo apt-get autoremove -y && sudo apt-get autoclean -y

wget –c "https://dev.mysql.com/get/${mysql_apt_deb}"
sudo dpkg -i $mysql_apt_deb # select 5.7

sudo apt-get update
sudo apt policy mysql-server #(it will show 5.x is the default candidate)

sudo apt-get -y install mysql-server
# ensure your host windows have no mysql service running
sudo service mysql start
#sudo service mysql stop
