#!/bin/bash
php_vesion=7.4
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install wget zip unzip
echo "Install PHP ${php_vesion}"
sudo apt-get install php${php_vesion}-fpm -y
echo "PHP version..."
php -v
sudo apt-get install -y php${php_vesion}-{bcmath,bz2,intl,gd,mbstring,mysql,zip,curl,xml,imagick,cli,xmlrpc,dom,xdebug}
echo "Install Composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
echo "Composer version..."
composer --version
echo "Done"
