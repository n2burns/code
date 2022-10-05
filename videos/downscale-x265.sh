#/bin/bash

#downscale_sd.sh

#search for videos in input folder that are larger than the requested 
#resolution, resize to the requested resolution

#extended pattern matching
shopt -s extglob

function usage {
        echo "usage: $0 {480|720|1080} Dir "
}

if [ $# = 2 ]; then
	cd "$2"
  declare -r orgDir=`pwd`
  declare -r q="${1//[!0-9]/}"
  if [ "$q" = 480 ] || [ "$q" = 720 ] || [ "$q" = 1080 ]; then
    echo "GO"
  else
    usage
    exit 0
  fi
else
  usage
  exit 0
fi

dir="$orgDir"

function folders {
	rm "$dir/tmp.*"
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
  max=`echo "$q * 1.15" | bc -l`
  max=${max%.*}
	echo $height max is $max
	if [ "$height" -gt "$max" ]; then
		#get current file's video extension
		ext="${video##*.}"
		`ffmpeg -i "$video" -c:v libx265 -vf scale="-2:$q" "tmp.$ext"`
		#check that downscale has exited cleanly
		if [ $? == 0 ]; then
			`mv "$video" "$video.bak"`
			`mv "tmp.$ext" "$video"
		else
			`rm "tmp.$ext"
		fi
	elif [ $height -lt 552 ]; then
		echo "$video"
		echo "  $height is SD"
	elif [ $height -lt 828 ]; then
		echo "$video"
		echo "  $height is ~720p"
	elif [ $height -lt 1242 ]; then
		echo "$video"
		echo "  $height is ~1080p"
	else
		echo "$video"
		echo "SOMETHING WENT WRONG!!!"
	fi
}

rm "$orgDir/tmp.*"
folders
