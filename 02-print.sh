#!/bin/bash

echo Hello world

## Colour codes
#Red 31
#Green 32
#Yellow 33
#Blue 34
#Magenta 35
#Cyan 36

#Syntac: echo -e "\e[COLmHello\e[0m"

#-e option is to enable esc seq, without -e option, colours will not work
# "" Double quotes are mandatory for colours to work, otherwise it will not work.optionally we can use single quotes aslo, but preference way is double quotes
# \e[COLm --> this is to enable the colour, COL is one of the colour code
# \e[0 --> This is to disable the colour.

iecho -e "\e[31mText\e[0m in Red colour"

echo "One more line"

echo -e "Line1\n\nLine2"

echo -e "Word\t\tWord2"