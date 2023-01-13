#!/bin/bash


# Check if running as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root cannot run as $USER"
  echo "This script must be run as root cannot run as $USER" >> $(pwd)/scripterror.log
  exit 1
fi

# Creating a log file
if [ ! -f $(pwd)/scripterror.log ];then
        touch scripterror.log
fi

#Inputs a directory
echo 'please enter your /dir/path:'

read dir

if [ -d "$dir" ];
then
#	Take action if $DIR exists

#	Inputs a number
	echo 'enter number "n":'

	read num

	re='^[0-9]+$'
	if  [[ ! $num =~ $re ]] ;
	then
   	echo "error : ${num} Not a number";
	echo "error : ${num} Not a number" >> $(pwd)/scripterror.log
	exit 1
	fi

	find $dir -type f -ctime -$num -ls | wc -l > results.txt

	echo 'listing results.txt'

	cat results.txt

	echo Done!!

else
#  Control will jump here if $DIR does NOT exists
	echo "Error: ${dir} not found. Can not continue."
	echo "Error: ${dir} not found. Can not continue." >> $(pwd)/scripterror.log
	exit 1
fi
