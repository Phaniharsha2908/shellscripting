#!/bin/bash

echo -e "\e[36m Installing Ngnix \e[0m"
yum install nginx -y

echo -e "\e[36m Downloading Nginx content \e[0m"
#Let's download the HTDOCS content and deploy under the Nginx path.
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

#Deploy the downloaded content in Nginx Default Location.
echo -e "\e[36m Clean-up old content and extract it \e[0m"

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36 Starting Nginx \e[0"
#Finally restart the service once to effect the changes.
systemctl restart nginx
systemctl enable nginx
