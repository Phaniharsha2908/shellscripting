#!/bin/bash

source components/catalogue.sh

print "Configure Yum Repos"
curl -fsSL  https://rpm.nodesource.com/setup_16.x | sudo bash - &>>${LOG_FILE}
StatCheck $?

print "Install node.js"
yum install node.js &>>${LOG_FILE}
StatCheck $?

print "Adding user"
if [ $? -ne 0 ]; then
  print "Adding application user"
  useradd ${APP_USER} &>>${LOG_FILE}
  StatCheck $?
fi

print "Download App components"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
StatCheck $?

print "Cleanup old directory"
rm -rf /home/${APP_USER}/catalogue  &>>${LOG_FILE}
StatCheck $?

print "Extract app component"
cd /home/${APP_USER} &>>${LOG_FILE} && unzip /tmp/catalogue.zip &>>${LOG_FILE} && mv catalogue-main catalogue &>>${LOG_FILE}
StatCheck $?

print "Install app dependencies"
cd /home/${APP_USER}/catalogue &>>${LOG_FILE} && npm install &>>${LOG_FILE}
StatCheck $?

print "Fix user permissions"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER} &>>${LOG_FILE}
StatCheck $?

print "setup SystemD File"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'  /home/roboshop/catalogue/systemd.service &>>${LOG_FILE} && mv  /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${LOG_FILE}
StatCheck $?

print "Start calalogue service"
systemctl daemon-reload &>>${LOG_FILE} && systemctl restart catalogue && systemctl enable catalogue
StatCheck $?

