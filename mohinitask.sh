#!/bin/bash


echo "Welcome to my script"
echo "Let's copies and archives the nginx and apache log files"

#step1:Check if running as root
if [ "$(id -u)" != "0" ];
 then
 echo "The script must be run as root" 1>&2
 exit 
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

#step2:creating directory

echo Creating directory
value=$(mkdir test1 )
echo $value test1 directory create successfully ..!!!

#step3:copy the nginx and apache log files in directory

echo "Copy file in the nginx/apache log files in the directory"
cp -r /var/log/nginx test1 
cp -r /var/log/apache2 test1
echo Copy file successfully !!

#step4:archieve and compress log files

echo tar the apache2 and nginx log file
tar -cvzf nginx-$(date "+%Y.%m.%d-%H.%M.%S").tar.gz test1/nginx
echo you nginx file tar and compress successfullly

tar -cvzf apache2-$(date "+%Y.%m.%d-%H.%M.%S").tar.gz test1/apache2
echo you apache file tar and compress successfullly


#step5:Sends them to a directory "archives" in a different server by ssh

echo your file are sending to different server.
scp -r /home/mohini/archives prasad@10.0.60.248:
echo your files are sending successfully



