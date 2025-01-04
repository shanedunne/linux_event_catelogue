#!/bin/bash


# Author: Shane Dunne
# Description: This programme catalogues music events. Users can add entries, find entries, generate reports etc.
#	The search.sh allows the user to search for records by different categories or see the entire collection

# declare the eventStore file for searching within
eventStore="eventStore.csv"

# ensure the eventStore file exists before offering search options
if [ ! -e "$eventStore" ]
then
	echo "No records created yet. Create records to be able to use the search functionality"

else
	# display search options menu until the user decides to choose the exit option
	while true
	do
		echo -e "\nSelect one of the search options below: \n"
		echo "1 - View all events"
		echo "2 - Search by artist"
		echo "3 - Search by date"
		echo "4 - Search by venue"
		echo -e "5 - Exit search menu\n"
		read searchOption
		
		sleep 1
		
		case $searchOption in
			1)
				# display all events
				sleep 1
				cat "$eventStore"
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			
			2)
				# search by artist name
				echo -e "\nEnter the artist name you would like to search: "
				read artist
				
				sleep 1
				echo -e "\nSee results below: \n"
				grep -i "$artist" "$eventStore" || echo "No events found for " "$artist"
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			3)
				# search by date
				echo -e "\nEnter the date you would like to search (dd-mm-yyyy) : "
				read date
				
				sleep 1
				
				#ensure the date provided is in the correct format
				if [[ "$date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
				then
				
					echo -e "\nSee results below: \n"
					grep -i "$date" "$eventStore" || echo "No events found on " "$date"
				else
					echo -e "\nIncorrect date format entered, please try again"
				fi
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			4)
				# search by venue
				echo -e "\nEnter the venue you would like to search: "
				read venue
				
				sleep 1
				echo -e "\nSee results below: \n"
				grep -i "$venue" "$eventStore" || echo "No events found at " "$artist"
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			5)
				# exit search menu
				echo "Exiting the search menu"
				break
				;;
			*)
				echo "Invalid search option. Please select one of the options displayed on the menu"
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			esac
		done
fi

sleep 1
echo -e "\nReturning to the main menu...\n"
sleep 1
exit 0
		
			
		
