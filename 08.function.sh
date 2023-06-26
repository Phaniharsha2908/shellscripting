#!/bin/bash

#Variable: If we assign a name to set of data that is variable
#Function: if we assign a name to set of commands that is function

#SYNTAX

#func_name(){
#commands
#commands
# }

#Calling function
#func_name

##Declare a function

print_message(){
  echo "Hello, welcome to ${1} training"
  echo "I am good to learn"
  a=20
  echo "Value of a = $a"
  b=20
}

STAT(){
  echo Hello
  return 1
  echo Bye
}

a=10
print_message Devops

echo "main script argument ${1}"
STAT
echo Exist status of function STAT = $?
###Note: Function has always been declared first and then you call function later in the code

## Function cannot access the script parameters - you can pass the parameters while calling the function

## normal variables/global variables you can access in the function

## Variable declared in main program can be overwritten in function and vice versa.

## Function is a command, function have exit status as well.
