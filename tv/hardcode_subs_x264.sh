#!/bin/bash

#hardcode_subs.sh

#This script will add subtitles to all files in the input folder
#TODO detect if subtitles are embedded or are a separate file (or are missing)
#   For now, use a flag
#TODO if x265, convert to x264

shopt -s extglob

function usage {
	echo "usage: $0 inDir outDir [sepSubs]"
}

#if 3rd flag, use separate flags
if [ $# = 2 ]; then
	in="${1}"
	out="${2}"
	sub="embed"
elif [ $# = 3 ]; then
	#use separate subtitles
	in="${1}"
	out="${2}"
	sub="sep"
else
	usage
	exit 0
fi

#function that itterates through the folders
function dir {
	folder="$1"

	for file in "$folder/"*; do
  	if [ -d "$file" ]; then
      dir "$file"
		else
      encode "$file"
    fi
  done
}

function encode {
	file="$1"
	ext="${file##*.}"
	name="${file%.*}"
  name="${name##$in}"
	name="${name##/}"

  #echo "$ext"
	if [[ "$ext" =~ mp4|mkv|avi ]]; then
  	#TODO check if embedded subs
	  #TODO check if in x265
  	if [[ "$sub" == sep ]]; then
	  	ffmpeg -y -i "$in/$name"."$ext" -c:a copy -c:v libx264 -vf subtitles="$in/$name".en.srt "$out/$name.$ext"
	  else
		  ffmpeg -y -i "$in/$name"."$ext" -c:a copy -c:v libx264 -vf subtitles="$in/$name"."$ext" "$out/$name.$ext"
	  fi
  fi
}

dir "$in"
