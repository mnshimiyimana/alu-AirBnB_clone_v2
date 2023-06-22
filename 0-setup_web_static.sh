#!/usr/bin/env bash
# This script sets up nginx web server for deployment of web_static

# Install Nginx if it not already installed
sudo apt-get --fix-missing update
sudo apt install nginx -y

# Create folder /data/web_static/shared if it doesn't exist
sudo mkdir -p /data/web_static/shared/
# Create folder /data/web_static/releases/test if it doesn't exist
sudo mkdir -p /data/web_static/releases/test/
# Create fake HTML file /data/web_static/releases/test/index.html
sudo touch /data/web_static/releases/test/index.html
# Write simple HTML code to fake HTML file

echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body> " > /data/web_static/releases/test/index.html

# Create symbolic link /data/web_static/current linked to /data/web_static/releases/test   

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu:ubuntu /data
sudo chown -R ubuntu:ubuntu /etc/nginx/sites-available/default

# Write Nginx configuration to file
echo "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    error_page 404 /404.html;
    location = /404.html {
        root /var/www/html;
        internal;
    }
}" > /etc/nginx/sites-enabled/default
# Restart Nginx
sudo service nginx start
