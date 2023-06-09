#!/bin/bash
source components/common.sh
print "Setup MongoDB repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo  &>>$LOG_FILE
StatCheck $?

print "Install Mongo & Start Service"
yum install -y mongodb-org &>>$LOG_FILE
StatCheck $?

print "Update mongodb Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$LOG_FILE
StatCheck $?

print "start Mongodb"
systemctl enable mongod && systemctl restart mongod &>>$LOG_FILE
StatCheck $?

print "Downoload Schema"
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
StatCheck $?

print "Extract schema"
cd /tmp && unzip -o mongodb.zip &>>$LOG_FILE
StatCheck $?

print "Load schema"
cd mongodb-main && mongo < catalogue.js &>>$LOG_FILE && mongo < users.js &>>$LOG_FILE
StatCheck $?






## Every Database needs the schema to be loaded for the application to work.
#Download the schema and load it.
# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
