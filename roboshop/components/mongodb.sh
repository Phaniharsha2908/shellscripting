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
  echo -e "
          |------------------------$1-------------------" &>>$LOG_FILE
  echo -e "\e[36m $1 \e[0m"
}

LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_FILE


print "Setup MongoDB repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo >>&$LOG_FILE
StatCheck $?

print "Install Mongo & Start Service"
yum install -y mongodb-org >>&$LOG_FILE
StatCheck $?

print "Update mongodb Listen Address"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf >>&$LOG_FILE
StatCheck $?

print "start Mongodb"
systemctl enable mongod && systemctl start mongod >>&$LOG_FILE
StatCheck $?







## Every Database needs the schema to be loaded for the application to work.
#Download the schema and load it.
# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
