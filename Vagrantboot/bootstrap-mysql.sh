#!/bin/bash

PASSWORD=byebye
DBNAME=bx

apt-get install debconf-utils -y > /dev/null

debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"

apt-get install mysql-server -y

# Create a default database for us to initialize:
mysql -u root -p$PASSWORD -e "CREATE DATABASE $DBNAME;"
