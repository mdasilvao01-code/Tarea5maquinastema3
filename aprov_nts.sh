#!/bin/bash
apt-get update
apt-get install -y nfs-kernel-server

mkdir -p /var/nfs/web
echo "<h1>¡Hola desde NFS!</h1>" > /var/nfs/web/index.html

chown -R nobody:nogroup /var/nfs/web
chmod 755 /var/nfs/web

echo "/var/nfs/web 192.168.10.0/24(rw,sync,no_subtree_check)" >> /etc/exports
exportfs -a
systemctl restart nfs-kernel-server