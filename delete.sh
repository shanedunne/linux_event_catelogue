#!/bin/bash

# Description: This programme catalogues music events. Users can add entries, find entries, generate reports etc.
#	The delete.sh allows the user to delete records of events. First, the user can call the search script to find the event they want to delete. Then, the user can provide the date and artist name.
# by requireing two pieces of information, the user will not accidentally delete incorrect events.

# Declare the eventStore file for searching within
eventStore="eventStore.csv"

# Ensure the eventStore file exists before proceeding
if [ ! -e "$eventStore" ]
then
    echo "No records available to delete"
    sleep 1
else
	echo -e "You have choosen to delete an event\n"
	sleep 1
	echo -e "In order to find the event you would like to delete, please search for it in the records\n"
	sleep 1
	echo -e "Note that you will need the date and artist of the event to delete it\n"
	sleep 1
	echo -e "Would you like to proceed? (y/n) :\n"
	read proceedDeleting
	if [[ "$proceedDeleting" =~ ^[yY]$ ]]
	then
		# Display search options menu so the user can find the event they want to delete
		sleep 1
		cat "$eventStore"
		sleep 2
		echo -e "\nFind your artist name and date from above to proceed with deleting..."
		sleep 2
	else
		# return to the main menu
		./main.sh
	fi
	
    
	# Request the date and artist of the event the user wants to delete
	echo -e "\nPlease enter the date of the event you would like to delete (dd-mm-yyyy): "
	read date
	while ! [[ "$date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; do
		echo -e "\nYou have not entered the correct date format, please try again\n"
	        read date
	done

  	echo -e "\nPlease enter the artist whose event you would like to delete: "
	read artist

	# Display the event information to the user
	echo -e "\nYou have chosen the following event:\n"

	# Get the artist's events and then filter by the specific date
	if ! grep -i "$artist" "$eventStore" | grep -i "$date" > /dev/null
	then
		echo -e "\nWe could not find the event you were looking for. Please try again\n"
		sleep 1
		./delete.sh
	else
		

		# Confirm the user would like to delete the event they have chosen
		echo -e "\nAre you sure you would like to delete '$artist''s event on '$date'? (y/n):"
		read finalAnswer

		# If the user confirms they want to proceed with the deleting, then delete
		if [[ "$finalAnswer" =~ ^[yY]$ ]]
		then
			# Get line number to delete
			line=$(grep -ni "$artist" "$eventStore" | grep -i "$date" | cut -f1 -d":")

			# Delete the line number using sed in-place
			if [ ! -z "$line" ]
			then
		    		sed -i "${line}d" "$eventStore"
		    		echo "Event deleted"
			else
		    		echo "No matching events found to delete."
			fi
	    	else
			echo "You have not chosen to proceed with deleting the event"
	  	fi
	  fi
fi

echo -e "\nReturning to the main menu...\n"
sleep 1

# return to the main menu
exit 0
