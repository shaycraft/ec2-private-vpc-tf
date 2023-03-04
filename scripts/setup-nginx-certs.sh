#!/bin/bash
echo "Installing nginx..."
sudo apt-get update && sudo apt-get -y install nginx
echo "Nginx install complete..."
echo "Generating self-signed cert..."
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US"
echo "Attempting to copy nginx config now..."
sudo cp -f /tmp/terraform-nginx.config /etc/nginx/sites-available/default
echo "Attempting to copy cert config now..."
sudo cp -f /tmp/terraform-self-signed.config /etc/nginx/snippets/self-signed.conf
echo "Restarting nginx..."
sudo systemctl restart nginx