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

APP_USER=roboshop