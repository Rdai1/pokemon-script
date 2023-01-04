#!/bin/sh
#checking for file/error checking
filename=pokemon.csv
if [ -f $filename ]; then
	echo FILE \"$filename\" exists
else
	echo filename does not exist
	exit
fi

#looping through each line and temp variables to hold the header and counter
count=0
headerLine=temp
while read LINE
do
	#skips header
	if [ $count -gt 0 ]; then
	 	#gets type
		type=`echo $LINE | cut -d, -f3`

		#check if directory exists
		if [ ! -d $type ]; then
			#if not make directory and make a file with the header
			mkdir $type
			echo $headerLine >> $type/$type.csv
		fi
		#appened current line to respected header
		echo $LINE >> $type/$type.csv
		
	#obtain header
	else 
		headerLine=$LINE
	fi
	#add 1 to count
	count=`expr $count + 1`
done < $filename
