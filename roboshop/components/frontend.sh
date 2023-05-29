#!/bin/bash


yum install nginx -y
systemctl enable nginx
systemctl start nginx

#Let's download the HTDOCS content and deploy under the Nginx path.

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"


#Deploy the downloaded content in Nginx Default Location.

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

#Finally restart the service once to effect the changes.
systemctl restart nginx
systemctl enable nginx
