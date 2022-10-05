#/bin/bash

#eng_only.sh

#remove all non-english subtitles (if they exist) and all non-english audio 
# tracks (will output error if no non-english audio)

#extended pattern matching
shopt -s extglob

function usage {
        echo "usage: $0 Dir "
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
		#get current file's video extension
		ext="${video##*.}"
		`ffmpeg -i "$video" -map 0:v -map 0:a:m:language:eng -map 0:s:m:language:eng? -c copy "tmp.$ext"`
		#check that ffmpeg has exited cleanly
		if [ $? == 0 ]; then
			`mv "$video" "$video.bak"`
			`mv "tmp.$ext" "$video"
		else
			`rm "tmp.$ext"
		fi
}

folders
