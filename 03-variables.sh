a=100
b=devops


echo ${a}times
echo $b Traning


#{} are needed if variable is combined with other words with out spaces.


#all tge time we will not hardcode the value of a variable and we need data dynamically

DATE=2022-03-10
echo Today date is $DATE


DATE=$(date +%F)
echo Today date is $DATE

#Arthematic expression
#var=$((expression))

#example


x=10
y=20
ADD=$(($x+$y))
echo ADD = $ADD