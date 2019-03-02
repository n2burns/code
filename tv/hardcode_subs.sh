#!/bin/bash

#hardcode_subs.sh

#This script will add subtitles to all files in the input folder
#TODO detect if subtitles are embedded or are a separate file (or are missing)
#   For now, use a flag
#TODO if x265, convert to x264

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
function sub {
	folder="$1"

	for file in "$folder/"*; do
                if [ -d "$file" ]; then
                        sub "$file"
		else
                        encode "$file"
                fi
        done
}

function encode {
	file="$1"
	ext="${file##*.}"
	name="${file%.*}"
	name="${name##/}"
	#check if embedded subs
	#check if in x265
	if [[ "$sub" == sep ]]; then
		ffmpeg -i "$file"."$ext" -vf subtitles="$file".en.srt "$out/$file.$ext"
	else
		ffmpeg -i "$file"."$ext" -vf subtitles="$file"."$ext" "$out/$file.$ext"
	fi
}
