#!/bin/bash

#case and if are conditional commands, if command is  widely used because it has more options than case command

#if conditions

#if found in 3 forms

  #simple if
  #if [ expression ]
  #then
  #commands
  #fi
#example

#if [ expression ];then
#commonds
#else
#commands
#fi

#ELSE IF
#if [ expression1 ];then
#commands
#elif [ expression2 ]; then
#commands
#elif [ expression3 ]; then
#command
#else
#command
#fi

if [ 1 -eq 1 ]
then
  echo "hello"
fi

#Expressions are important
#1.String tests
  #Operator : ==,!=,-z
#2.Number tests
  #operators: -eq, -ne, -le, -lt, -gt, -ge
#3. File tests
  #Operators: https://tldp.org/LDP/abs/html/fto.html
  #https://www.tutorialspoint.com/unix/unix-file-operators.htm

a="abc"
if [ "$a" == "abc" ]; then
  echo "Both are equal"
fi

if [ "$a" != "abc" ]; then
  echo "Both are not equal"
fi

if [ -z "$b" ]; then
  echo b variable is emapty
fi
# One observation, I am using quotes for variables, and it is the best practice.

if [ "$b" == "abc" ]; then
  echo "Both are equal"
else
  echo "Both are not equal"
fi