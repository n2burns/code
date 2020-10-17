#/bin/bash

#downscale_sd.sh

#search for videos in input folder that are larger than 480p, move the orginal
#to backup, and resize to 480p

#extended pattern matching
shopt -s extglob

function usage {
        echo "usage: $0 Dir"
}

if [ $# = 1 ]; then
	cd "$1"
        declare -r orgDir=`pwd`
else
        usage
        exit 0
fi

dir="$orgDir"

function folders {
	#loop throgh video files
	for i in "$dir"/*.@(avi|mp4|mkv); do
		if [ -f "$i" ]; then
			video="$i"
			encode
		fi
	done
	#loop through folders to find additional files to list/process
	for i in "$dir"/*; do
		if [ -d "$i" ]; then
	    		cd "$i"
			dir=`pwd`
			folders
		fi
	done
}

function encode {
	#find the size of the video and categorize it as 480p, 720p, 1080p
	# or "Other"
	height=`mediainfo "$video" | grep Height`
	height="${height//[!0-9]/}"
	echo $height
	if [ $height -gt 550 ]; then
		#backup
		#`mv "$video" "$video.bak"`
		#encode
		#`ffmpeg -i "$video.bak" -vf scale="-2:480" "$video"`


		#get current file's video extension
		ext="${video##*.}"
		`ffmpeg -i "$video" -vf scale="-2:480" "tmp.$ext"`
		#check that downscale has exited cleanly
		if [ $? == 0 ]; then
			`mv "$video" "$video.bak"`
			`mv "tmp.$ext" "$video"
		else
			`rm "tmp.$ext"
		fi
	else
		echo "$video"
		echo "  $height is SD"
	fi
}

folders
