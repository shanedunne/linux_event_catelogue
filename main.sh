#!/bin/bash

# Author: Shane Dunne
# Description: This programme catalogues music events. Users can add entries, find entries, generate reports etc.
#	The main.sh is the controller of all actions possible within this programme and gernerates the menu and menu options

echo -e "\nWelcome to the music events cataloge main menu\n"
sleep 1
echo -e  "Please take a look at the options below\n"
sleep 1

# Add a loop here so that when a user returns from one of the other scripts, they can choose further action and don't have to read the initial message again

while true
do
	echo "Add:    Add a new record to the music event catalogue"
	echo "Search: Search for particular events by filtering via artist, venue, date etc.. "
	echo "Delete: Delete a specified record"
	echo "Report: Generate a report on music events stored in the catalogue"
	echo -e "Exit:   Exit programme\n"
	sleep 3

	PS3="Please enter your chosen action: "
	options=("Add" "Search" "Delete" "Report" "Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Add")
				echo -e "Add record\n"
				sleep 1
				"./add.sh"
				break
				;;

			"Search")
				echo -e "Search the records\n"
				"./search.sh"
				break
				;;
			"Delete")
				echo -e "Delete a record\n"
				./delete.sh
				break
				;;
			"Report")
				echo -e "Generate a report\n"
				./report.sh
				break
				;;
			"Exit")
				echo "Exiting programme"
				exit 0
				;;
			*) echo "invalid option $REPLY"
		esac
	done
done
