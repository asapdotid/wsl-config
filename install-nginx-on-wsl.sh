#!/bin/bash

echo "Install Nginx"
sudo apt-get update
sudo apt-get install nginx -y
echo "Nginx version..."
nginx -v
echo "Done"