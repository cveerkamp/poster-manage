#!/bin/bash

#Script Name:    Poster TV Update Script
#Description:    Script designed to be ran at intervals (ex. every 15min) that queries a URL with a specially designed page, reads the hash
#                from the first line of the page, and compares it to the locally stored hash, and if they differ, the local images are deleted
#                and new images are downloaded and the slideshow restarted
#Author:         Cody Veerkamp
#Origin Date:    8/1/2022
#Version:        1.0
#Version Date:   8/6/2022
#Author URI:     https://github.com/cveerkamp/poster-manage

#Query the website for the current hash version and image URLs
current=$(wget http://url-to-website-with-the-images -q -O -)

#Save the hash on the first line to it's own variable
revision=`echo "${current}" | head -1`

#Read locally stored hash to variable
myrev=$(<rev.md5)

#If script was not able to read URL (i.e. no internet, website down, etc.) then set "revision" equal to "myrev", 
#to trick the script into thinking it is up-to-date & rest of script is skipped
if [ "$current" == "" ]; then
	revision="${myrev}"
fi

#Check if current does not equal myrev
if [ "$revision" != "$myrev" ]; then
	#Posters need updated

	#Update local revision number
	echo "${revision}" > rev.md5

	#Kill existing process of fbi
	pkill -f "fbi"

	#Delete existing poster images
	rm *.jpg
	rm *.png

	#Download new images
	first=true
	while IFS= read -r line; do
		#If this is the first line, skip, as the first line has the hash
		if [ "$first" = true ]; then
			#Set first to false so subsequent lines will be processed
			first=false
		else
			#Download the image file on this line
			wget "$line"
		fi
        done <<< "$current"

	#Restart fbi, showing any jpg or png files in the working directory
	exec fbi -a --noverbose -t 5 -T 1 -d /dev/fb0 *.{jpg,png} &
fi