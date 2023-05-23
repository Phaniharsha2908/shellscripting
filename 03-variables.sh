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

#Variables names can have only characters a-z.A-Z,0-9,_(underscore)
#special characters are not allowed
#Avariable should not start with a number and it can start with a underscore
#Variables by default will not have any data types.
#As a user you should know that what data would come, since there is no data types.

##In Linux shell script people from unix/Linux back ground considers the variables names will all CAPS
#EXAMPLE: COURSE_NAME



##Arrays

c=(10 20 30 small large)
echo First value of Array = ${c[0]}
echo Second value of Array = ${c[1]}
echo Count of all the values of Array = ${#c[*]}
echo All the values of Array = ${c[*]}

##Local variables/Accessing env variables  or local properties

echo Traning = ${TRANINING}
#using export it will work other wise it will not work

export TRANINING = DevOps

