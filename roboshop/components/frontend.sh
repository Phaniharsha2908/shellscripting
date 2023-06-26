#!/bin/bash

USER_ID=$(id -u)
if [ "$USER_ID" != 0 ]; then
  echo "you should run your script as sudo or root user"
  exit 1
fi

StatCheck(){
  if [ $1 == 0 ]; then
    echo -e "\e[32mSUCCESS\e[0"
  else
    echo -e "\e[31mFAILURE\e[0"
    exit 2
  fi
}

print(){
  echo -e "\e[36m $1 \e[0m"
}

LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE
print "Downloading Nginx"
yum install nginx -y >>$LOG_FILE
StatCheck $?

print "Downloading Nginx content"
#Let's download the HTDOCS content and deploy under the Nginx path.
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>$LOG_FILE
StatCheck $?

#Deploy the downloaded content in Nginx Default Location.
print "Clean-up old content and extract it"

rm -rf /usr/share/nginx/html/* >>$LOG_FILE
StatCheck $?

Print "switching nginx directory"
cd /usr/share/nginx/html/ >>$LOG_FILE

print "Extracting Archive"
unzip /tmp/frontend.zip $LOG_FILE && mv frontend-main/* . $LOG_FILE && mv static/* . >>$LOG_FILE
StatCheck $?

print "Update roboshop configuration"
rm -rf frontend-main README.md >>$LOG_FILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf >>$LOG_FILE
StatCheck $?

echo -e "\e[36 Starting Nginx \e[0"
#Finally restart the service once to effect the changes.
systemctl restart nginx && systemctl enable nginx >>$LOG_FILE
StatCheck $?


