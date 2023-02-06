#!/usr/bin/bash

sudo apt-get update -y 
sudo apt-get upgrade -y
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo apt-get install nginx
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source .bashrc
nvm install 18
sudo apt-get install firewalld
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
sudo firewall-cmd --reload
cd /etc/nginx/
sudo rm -rf sites-available/default
sudo rm -rf sites-enabled/default
cd sites-available
sudo touch getluxe.tech.conf
sudo ln getluxe.tech.conf ../sites-enabled/getluxe.tech.conf 
sudo snap install core
sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
