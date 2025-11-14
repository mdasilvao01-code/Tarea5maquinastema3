#!/bin/bash
apt-get update
apt-get install -y apache2 nfs-common

mkdir -p /var/www/html
mount -t nfs 192.168.10.25:/var/nfs/web /var/www/html

echo "web1" > /var/www/html/index.html
systemctl restart apache2