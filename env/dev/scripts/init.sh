#!/bin/bash

sudo apt update
sudo apt install -y nala neofetch nginx python-is-python3

sudo systemctl enable nginx
sudo systemctl start nginx

echo ${index} | sudo tee /var/www/html/index.html

curl http://localhost/
