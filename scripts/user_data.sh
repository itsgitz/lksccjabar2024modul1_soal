#!/bin/bash

# author: @itsgitz

DOMAIN_NAME="modul1.kotakserver.my.id"
DOCUMENT_ROOT="/var/www/html"
NGINX_CONFIGURATION_DIR="/etc/nginx"
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
rm $DOCUMENT_ROOT/index.nginx-debian.html

# remove default Nginx configuration files
rm "$NGINX_CONFIGURATION_DIR/sites-available/default"
rm "$NGINX_CONFIGURATION_DIR/sites-enabled/default"

# download index.php from the gist
wget $GIST_URL -O $DOCUMENT_ROOT/index.php

chown ubuntu:www-data $DOCUMENT_ROOT/index.php
chmod 775 $DOCUMENT_ROOT/index.php

cat <<EOF > $NGINX_CONFIGURATION_DIR/sites-available/default
server {
    listen 80;
    server_name $DOMAIN_NAME;
    root /var/www/html;

	access_log /var/log/nginx/$DOMAIN_NAME-access.log;
	error_log /var/log/nginx/$DOMAIN_NAME-error.log;

    index index.php;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# restart web server
systemctl restart nginx
