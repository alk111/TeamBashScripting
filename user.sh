#!/bin/bash

## Check if running as root


	 if [ "$(id -u)" != "0" ]; then
  	 echo "This script must be run as root" 1>&2
  	 exit 1
	 fi


## Create user

create_user()
{
	while :
	do
		read -p "Enter user name:" user
		if id $user &> /etc/null
		then
			echo "User already exist...(try again with another name)"
		else
			adduser $user
			echo "$user created successfully"
			return 0
		fi
	done
}


view()

{
	users=$(awk -F: '$7=="/bin/bash" { print $1}' /etc/passwd)
	for user in $users
	do
		echo "User: $user , $(id $user | cut -d " " -f 1)"
	done
}

Delete_User()

{

	read -p "Enter user name:" user
	userdel -r -f $user
	echo 'user has been deleted successfully !!'
	#echo $user 'has been deleted successfully !!' >> $(pwd)/errorlogfile

}


Update_User()

{

while :
        do
                read -p "Enter user name:" user
                if id $user &> /etc/null

		 then

                	 read -p "Enter new user name:" new_user
       			 usermod -l $new_user $user

			 echo 'User name has change successfully'

                 return 0
		 else
                       	 echo $user "does not exist"
			 echo $user "does not exist" >> $(pwd)/errorlogfile 

                       	 return 0
                fi
        done

}

while :
do
	echo "
	      1. Create new user
	      2. List user
	      3. Delete user
	      4. Update user
	      5. exit"
        read -p "Enter your choice:" choice


	case $choice in
		1) create_user ;;
		2) view ;;
		3) Delete_User ;;
		4) Update_User ;;
		5) echo "ThankYou, have a nice day...."
		   exit 1 ;;

	esac
	sleep 4
	clear
done
