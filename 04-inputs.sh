#!/bin/bash

read -p "Enter your name: " name
echo "Your Name = $name"


##Special variables
##$0-$n, $*/$@, $#

a=$1
echo $a

echo Script name = $0
echo First Argument = $1
echo All Argument = $*
echo Number of Arguments =$#
