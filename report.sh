#!/bin/bash


# Author: Shane Dunne
# Description: This programme catalogues music events. Users can add entries, find entries, generate reports etc.
#	The report.sh allows the user to generate reports based on certain criteria

# Declare the eventStore file for searching within
eventStore="eventStore.csv"

# Ensure the eventStore file exists before proceeding
if [ ! -e "$eventStore" ]
then
    echo "No records available to delete"
    ./main.sh
else
	# display search options menu until the user decides to choose the exit option
	while true
	do
		echo -e "\nSelect one of the report options below: \n"
		echo "1 - View all events sorted by cheapest ticket first"
		echo "2 - View all events sorted by dearest ticket first"
		echo "3 - Filter events by tickets over a given price"
		echo "4 - Filter events by tickets under a given price"
		echo -e "5 - Exit report menu\n"
		read reportOption
		
		sleep 1
		
		case $reportOption in
			1)
				# Display all events sorted by cheapest ticket first
				sleep 1
				header=$(head -n 1 "$eventStore")
				tail -n +2 "$eventStore" | sort -t ',' -k 6,6n | sed "1i$header"
				sleep 2
				;;
			2)
				# Display all events sorted by dearest ticket first
				sleep 1
				header=$(head -n 1 "$eventStore")
				tail -n +2 "$eventStore" | sort -t ',' -k 6,6nr | sed "1i$header"
				sleep 2
				;;

			3)
				# Filter events by tickets over a given price
				echo -e "\nEnter the price you would like to see events costing more than : "
				read price
				
				sleep 1
				
				if [[ "$price" =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]
				then
					echo -e "\nPrinting events where ticket prices are greater than" "$price" "\n"
					sleep 1
					header=$(head -n 1 "$eventStore")
    					echo "$header"
					tail -n +2 "$eventStore" | awk -F',' -v p="$price" 'BEGIN {OFS=","} {if ($6 > p) print $0}'
				else
					echo -e "\nPlease provide a price format"
				fi

					
				
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			4)
				# Filter events by tickets under a given price
				echo -e "\nEnter the price you would like to see events costing less than : "
				read price
				
				sleep 1
				
				if [[ "$price" =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]
				then
					echo -e "\nPrinting events where ticket prices are less than" "$price" "\n"
					sleep 1
					header=$(head -n 1 "$eventStore")
    					echo "$header"
					tail -n +2 "$eventStore" | awk -F',' -v p="$price" 'BEGIN {OFS=","} {if ($6 < p) print $0}'
				else
					echo -e "\nPlease provide a price format"
				fi
				
				# allow the user a couple of seconds to view the records before the menu reappears
				sleep 2
				;;
			5)
				# exit reports menu
				echo "Exiting the reports menu"
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

#return to main menu

echo -e "\nReturning to the main menu...\n"
sleep 1
exit 0
