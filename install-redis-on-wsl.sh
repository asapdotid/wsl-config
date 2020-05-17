#!/bin/bash

echo "Install Redis Server"
sudo apt-get update
sudo apt-get install redis -y
echo "Redis Server version..."
redis-server --version
echo "Done"