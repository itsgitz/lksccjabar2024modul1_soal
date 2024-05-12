#!/bin/bash

# author: @itsgitz

DOCUMENT_ROOT="/var/www/html"
GIST_URL="https://gist.githubusercontent.com/itsgitz/d062c142d94eba2381eca6e1a6d9c0ed/raw/472c5ec9373b9f40930ed3c9afb093df8c23a9e7/index.php"

# Add Ondrej's PPA for installing the latest PHP version
add-apt-repository ppa:ondrej/php -y

# update the OS applications and dependencies
apt-get update -y

# install nginx
apt-get install nginx -y

# install php
apt-get install php8.3 php8.3-cli php8.3-fpm -y

nginx -v
php -v

# remove default Nginx html file
rm $DOCUMENT_ROOT/index.html

# download index.php from the gist
wget $GIST_URL -O /var/www/html/index.php
