#!/bin/bash
source components/common.sh
print "Downloading Nginx"
yum install nginx -y &>>$LOG_FILE
StatCheck $?

print "Downloading Nginx content"
#Let's download the HTDOCS content and deploy under the Nginx path.
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>$LOG_FILE
StatCheck $?

#Deploy the downloaded content in Nginx Default Location.
print "Clean-up old content and extract it"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
StatCheck $?

print "switching nginx directory"
cd /usr/share/nginx/html/ &>>$LOG_FILE

print "Extracting Archive"
unzip /tmp/frontend.zip >>$LOG_FILE && mv frontend-main/* . >>$LOG_FILE && mv static/*  . &>>$LOG_FILE
StatCheck $?

print "Update roboshop configuration"
rm -rf frontend-main README.md &>>$LOG_FILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
sed -i -e '/catalogue/s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
StatCheck $?


print Starting Nginx
#Finally restart the service once to effect the changes.
systemctl restart nginx && systemctl enable nginx &>>$LOG_FILE
StatCheck $?


