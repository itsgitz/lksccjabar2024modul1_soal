#!/bin/bash

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
