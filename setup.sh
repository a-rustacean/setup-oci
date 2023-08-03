#!/usr/bin/bash

sudo apt-get update -y 
sudo apt-get upgrade -y
sudo apt-get install nodejs npm nginx libkrb5-dev -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
nvm install --lts
sudo apt-get install firewalld -y
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
sudo firewall-cmd --reload
cd /etc/nginx/
sudo rm -rf sites-available/default
sudo rm -rf sites-enabled/default
cd sites-available
sudo echo "server {
  listen 80;
  listen [::]:80;
  server_name example.com;

  location / {
    proxy_pass       http://localhost:3000;
    proxy_set_header Host                   \$http_host;
    proxy_set_header X-Forwarded-For        \$remote_addr;
    proxy_set_header Upgrade                \$http_upgrade;
    proxy_set_header Connection             \"Upgrade\";
  }
}" > default-website.conf
cd ..
sudo ln -s $(pwd)/sites-available/default-website.conf $(pwd)/sites-enabled/default-website.conf 
sudo snap install core
sudo snap refresh core
sudo apt-get remove certbot -y
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
