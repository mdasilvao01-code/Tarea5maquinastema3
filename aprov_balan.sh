#!/bin/bash
apt-get update
apt-get install -y apache2

# Activar módulos necesarios
a2enmod proxy
a2enmod proxy_balancer
a2enmod proxy_http
a2enmod lbmethod_byrequests

# Crear configuración del balanceador
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ProxyPreserveHost On

    <Proxy "balancer://webcluster">
        BalancerMember http://192.168.10.20:80
        BalancerMember http://192.168.10.21:80
        ProxySet lbmethod=byrequests
    </Proxy>

    ProxyPass "/" "balancer://webcluster/"
    ProxyPassReverse "/" "balancer://webcluster/"
</VirtualHost>
EOF

# Reiniciar Apache para aplicar cambios
systemctl restart apache2