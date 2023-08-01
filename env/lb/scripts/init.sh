#!/bin/bash

sudo apt update
sudo apt install -y nala neofetch nginx python-is-python3 inetutils-ping inetutils-traceroute tcpdump dnsutils

sudo apt install -y vim


sudo systemctl enable nginx
sudo systemctl start nginx

export HOST=`hostname`

echo "<h1>$HOST</h1>" | sudo tee /var/www/html/index.html

curl http://localhost/
