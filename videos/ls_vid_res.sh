#/bin/bash

#ls_vid_res.sh

#lists all video files (avi, mp4, mkv) in the input folder (and sub-folders) and uses mediainfo to give their vertical resolution

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
			echo $i	
			height=`mediainfo "$i" | grep Height`
			height="${height//[!0-9]/}"
			echo $height
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

folders
