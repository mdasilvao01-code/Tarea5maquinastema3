#!/bin/bash
apt-get update
apt-get install -y git mariadb-server

cd /home/vagrant

# Clonar solo si no existe
if [ ! -d "iaw-practica-lamp" ]; then
    git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
fi

cd /home/vagrant/iaw-practica-lamp/db

# Crear base de datos y ejecutar el script SQL
DB_NAME="mario"
DB_USER="root"

# Asegurarse de que el servicio esté activo
systemctl start mariadb

# Crear la base de datos si no existe
mysql -u $DB_USER -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Importar el archivo SQL
if [ -f "database.sql" ]; then
    mysql -u $DB_USER $DB_NAME < database.sql
else
    echo "❌ El archivo database.sql no se encuentra en iaw-practica-lamp/db"
    exit 1
fi