#!/bin/bash

echo "Install MySQL 8.0"
sudo apt-get update
sudo apt-get -y install mysql-server
echo "MySQL version..."
mysql --version
echo "MySQL secure installation..."
sudo mysql_secure_installation
echo "Done"