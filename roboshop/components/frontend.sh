#!/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" == 0 ]; then
  echo "you should run your script as sudo or root user"
  exit 1
fi

echo -e "\e[36m Installing Ngnix \e[0m"
yum install nginx -y

if [ $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0"
else
  echo -e "\e[31mFAILURE\e[0"
  exit 2
fi
echo -e "\e[36m Downloading Nginx content \e[0m"
#Let's download the HTDOCS content and deploy under the Nginx path.
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0"
else
  echo -e "\e[31mFAILURE\e[0"
  exit 2
fi

#Deploy the downloaded content in Nginx Default Location.
echo -e "\e[36m Clean-up old content and extract it \e[0m"

rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0"
else
  echo -e "\e[31mFAILURE\e[0"
  exit 2
fi
echo -e "\e[36 Starting Nginx \e[0"
#Finally restart the service once to effect the changes.
systemctl restart nginx
if [ $? == 0 ]; then
  echo -e "\e[32mSUCCESS\e[0"
else
  echo -e "\e[31mFAILURE\e[0"
  exit 2
fi
systemctl enable nginx
