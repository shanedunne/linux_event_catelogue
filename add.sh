#!/bin/bash


# Author: Shane Dunne
# Description: This programme catalogues music events. Users can add entries, find entries, generate reports etc.
#	The main.sh is the controller of all actions possible within this programme and gernerates the menu and menu options

# add csv file variable for use when adding records
eventStore="eventStore.csv"


echo -e "You have choosen to add a report\n"
sleep 1
echo -e "Follow the instructions to add a record\n"
sleep 1

count=0
while [ $count -lt 6 ]
do
	#get artist name
	if [ $count -eq 0 ]
	then
		echo -e "Please enter the artist name\n"
		read artist

		# check to ensure the entry is not enpty
		if ! [ -z "${artist}" ]
		then
			count=$((count+1))
		else
			echo -e "Cannot proceed with a blank entry, please try again/n"
		fi

	# get artist email address
	elif [ $count -eq 1 ]
	then
		echo -e "Please enter the artist email\n"
		read artistEmail

		# check to ensure that the correct email format is entered
		if [[ "$artistEmail" == *"@"*"."* ]]
		then
			count=$((count+1))
		else
			echo -e "Please enter an email address\n"
		fi

	# get the artists phone number
	elif [ $count -eq 2 ]
	then
		echo -e "Please enter the artists contact number\n"
		read artistPhoneNumber

		# check that the entry is numbers
		if [[ "$artistPhoneNumber" =~ ^[0-9]{10,15}$ ]]
		then
			count=$((count+1))
		else
			echo -e "Please enter a valid phone number, digits only"
		fi

	# get the venue name
	elif [ $count -eq 3 ]
	then
		echo -e "Please enter the name of the venue\n"
		read venue

		# check to make sure the entry isn't balnk
		if  [ -z "$venue" ]
		then
			echo -e "Please enter a valid venue"
		else
			 count=$((count+1))
		fi

	# get the date of the event
	elif [ $count -eq 4 ]
	then
		echo -e "Please enter the date of the event (DD-MM-YYYY)"
		read date

		# check the date is in the correct format
		if [[ "$date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
		then
			# check to make sure the artist isn't already booked for that date
			if ! grep -i "$artist" "$eventStore" | grep -i "$date"
			then
				count=$((count+1))
			else
				# if artist is double booked, let user know and return them to the main menu
				sleep 1
				echo -e "\n" "$artist" "is already booked for another event on" "$date"
				sleep 1
				echo -e "\n Returning to the main menu..."
				sleep 1
				./main.sh
			fi
		else
			echo -e "You have entered an invalid date, please try again"
		fi

	# get ticket price
	elif [ $count -eq 5 ]
	then
		echo -e "Please enter the ticket price"
		read ticketPrice

		# check to ensure the formatting is correct
		if [[ "$ticketPrice" =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]
		then
			count=$((count+1))
		else
			echo -e "Enter a correct ticket price"
		fi
	fi
done
echo -e "\nYou have entered the following data\n"
sleep 1
echo -e "Artist Name: " $artist
echo -e "Artist Email Address: " $artistEmail
echo -e "Artist Phone Number: " $artistPhoneNumber
echo -e "Venue: " $venue
echo -e "Event Date: " $date
echo -e "Ticket Price: " $ticketPrice
sleep 1

echo -e "\n Are you satisfied you have entered the correct details? (Enter y/n): "
echo -e "\nYou can also choose to quit and return to the main menu by pressing (q) "

read response
case $response in

	[yY])
	echo "Okay, proceeding to add record to the catalogue"
	
	# create variable to store newEvent information
	newEvent="$artist,$artistEmail,$artistPhoneNumber,$venue,$date,$ticketPrice"
	
	if [ -e "$eventStore" ]
	then
		echo -e "Adding $artist's event to the event records"
		echo "$newEvent" >> "$eventStore"
		sleep 1
		echo -e "\nEvent successfully added"
	else
	# if this is the first entry, add the field titles first
	echo "Artist,Artist Email,Artist Phone Number,Venue,Date,Ticket Price" > "$eventStore"
	
	echo "$newEvent" >> "$eventStore"
		sleep 1
		echo -e "\nEvent successfully added"
	fi
	;;
	
	[qQ])
	echo -e "Okay, returning to the main menu..."
	sleep 1
	./main.sh
	;;

	[nN])
	echo -e "Okay, what data would you like to change? :"

	while true
		do
		echo -e "\nPlease enter the number of the field you would like to change\n"
		echo "1 - Artist Name"
		echo "2 - Artist Email Address"
		echo "3 - Artist Phone Number"
		echo "4 - Venue"
		echo "5 - Event Date"
		echo "6 - Ticket Price"
		echo "7 - Exit editing menu"
		read editNumber

		sleep 1
		case $editNumber in
			1)
				echo "Enter new Artist Name: "
				read artist
				# check to ensure the entry is not enpty
				while [ -z "$artist" ]
				do
					echo -e "Blank entry provided. Please enter the artist name"
					echo "Enter new Artist Name: "
					read artist
				done
				
				sleep 1
				echo -e "\nArtist Name updated to: " $artist
				;;
			2)
				echo "Enter new Artist Email Address: "
				read artistEmail
				
				# check to ensure that the correct email format is entered
				while ! [[ "$artistEmail" == *"@"*"."* ]]
				do
					echo -e "You have not entered an email address\n"
					echo -e "Enter new Artist Email Address: "
					read artistEmail
				done
				
				sleep 1
				echo -e "\nArtist Email updated to: " $artistEmail
				;;
			3)
				echo "Enter new Artist Phone Number: "
				read artistPhoneNumber
				
				# check that the entry is numbers
				while ! [[ "$artistPhoneNumber" =~ ^[0-9]{10,15}$ ]]
				do
					echo -e "You have not entered an phone number\n"
					echo -e "Enter new Artist Phone Number: "
					read artistPhoneNumber
				done
				
				sleep 1
				echo -e "\nArtist Phone Number updated to: " $artistPhoneNumber
				;;
			4)
				echo "Enter new Venue: "
				read venue
				
				# check that a blank entry has not been provided
				while [ -z "$venue" ]
				do
					echo -e "Blank entry provided. Please enter the venue"
					echo "Enter new Venue: "
					read venue
				done
				
				sleep 1
				echo -e "\nVenue updated to: " $venue
				;;
			5)
				echo "Enter new Event Date (dd-mm-yyyy): "
				read date
				
				# check the date is in the correct format
				while ! [[ "$date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
				do
					echo -e "Incorrect date entered"
					echo "Enter new Date (dd-mm-yyyy): "
					read date
				done
				
				sleep 1
				echo -e "\nDate updated to: " $date
				;;
			6)
				echo "Enter new Ticket Price: "
				read ticketPrice
				
				# check to make sure correct formatting provided
				while ! [[ "$ticketPrice" =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]
				
				do
					echo -e "Incorrect ticket price format entered"
					echo "Enter new ticket price: "
					read ticketPrice
				done
				
				sleep 1
				echo -e "\nTicket Price updated to: " $ticketPrice
				;;
			7)
				echo "Exiting edit menu"
				break
				;;
			*)
				echo "Incorrect option. Enter a number from 1-7"
				;;
		esac
	done

	echo -e "\n Updated details"
	echo "Artist Name: " $artist
	echo "Artist Email: " $artistEmail
	echo "Artist Phone Number: " $artistPhoneNumber
	echo "Venue: " $venue
	echo "Event Date: " $date
	echo "Ticket Price: " $ticketPrice
	sleep 1
	echo -e "\nAdding updated event to the event records"
	
	# create variable to store newEvent information
	newEvent="$artist,$artistEmail,$artistPhoneNumber,$venue,$date,$ticketPrice"
	
	# check to see if the event store has been created already
	if [ -e "$eventStore" ]
	then
		# if so, append the record to the csv file
		echo -e "Adding $artist's event to the event records"
		echo "$newEvent" >> "$eventStore"
		sleep 1
		echo -e "\nEvent successfully added"
	else
	# if this is the first entry, add the field titles first
	echo "Artist,Artist Email,Artist Phone Number,Venue,Date,Ticket Price" > "$eventStore"
	
	echo "$newEvent" >> "$eventStore"
		sleep 1
		echo -e "\nEvent successfully added"
	fi
	;;

	*)
	echo "Invalid entry"
	;;
esac

sleep 1
echo -e "Records successfully added/n"
sleep 1
echo -e "Returning to the main menu...\n"

# return to the main menu
exit 0
