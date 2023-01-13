#!/bin/bash

#Check if running as root
 if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   echo "This script must be run as root cannot run as $USER" >> $(pwd)/scripterror.log
   exit 1
 fi

#Create ssh key

create_ssh_key()
{
	while :
	do
		read -p "Enter key name:" key
		ssh-keygen -t rsa -N "" -f /home/aakash/.ssh/$key
		echo "key created successfully"
		return 0
	done
}

#List keys
view()

{
ls -l -I "authorized_keys" /home/aakash/.ssh
}

#Delete keys
Delete_key()
{

	read -p "Enter key name:" key
	rm /home/aakash/.ssh/$key
	rm /home/aakash/.ssh/$key.pub
	echo 'key has been deleted successfully !!'



}

while :
do

	echo "
	      1. Create new key
	      2. List key
	      3. Delete
	      4. exit"
        read -p "Enter your choice:" choice


	case $choice in

		1) create_ssh_key ;;
		2) view ;;
		3) Delete_key ;;
		4) echo "ThankYou, have a nice day...."
		   exit 1 ;;

	esac
	sleep 4
	clear
done
