#!/bin/bash

sudo apt-get update
echo "Install PHP FPM"
sudo apt-get install php php-fpm -y
echo "PHP version..."
php -v
echo "PHP Support Service installation"
sudo apt-get install -y php-{bcmath,bz2,json,intl,pear,pdo,gd,mbstring,mysql,pgsql,redis,zip,curl,xml,imagick,cli,xmlrpc,dom,xdebug}
echo "Install Composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
echo "Composer version..."
composer --version
echo "Done"
