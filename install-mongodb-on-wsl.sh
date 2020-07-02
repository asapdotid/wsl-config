#!/bin/bash

mongo_version=4.2
echo "Install MongoDB ORG"
wget -qO - https://www.mongodb.org/static/pgp/server-${mongo_version}.asc | sudo apt-key add -;
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${mongo_version} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${mongo_version}.list;
sudo apt update
sudo apt install mongodb-org
echo "MongoDB Version"
mongod --version
echo "Done"