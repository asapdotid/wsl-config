#!/bin/bash

echo "Install Postgrsql 12"
sudo apt-get update
sudo apt -y install postgresql
echo "Postgresql version..."
psql --version
echo "Done"