#!/bin/bash


#flac2opus.sh

#This script is designed to keep an up-to-date downscale of all of the flac
#in a library, in opus format. It is modified from an earlier script called
#flac2ogg.sh
#
#It itterates through all the files in the flac folder and sees if a
#matching file exists in the opus folder. If not, it creates a new opus file using the supplied quality

#TODO highlight to the user errors reported by opusenc

shopt -s extglob

function usage {
	echo "usage: $0 flacDir opusDir [bitrate]"
}

#if args exist, use them. If not, use the supplied data
if [ $# = 2 ]; then
	flac="${1%/}"
	opus="${2%/}"
	q="48.0"
elif [ $# = 3 ]; then
	flac="${1%/}"
	opus="${2%/}"
	q="$3"
else
	usage
	exit 0
fi
output="flac2opus-`date +%Y%m%d_%H%M%S`.log"

#function that itterates through the folders
function sub {
	folder="$1"

	for file in "$folder/"*; do
		if [ -d "$file" ]; then
			dir="${file##*/}"
			mkdir "$opus/$dir"
			sub "$file"
		else
			encode "$file"
		fi
	done
}

#check if output file already exists
#if it doesn't exist, encode it
function encode {
	f="$1"
	file="${f##$flac}"
	file="${file##/}"
	if [ -e "$opus/$file" ]; then
		echo "$opus/$file already exists"
	elif [[ "$file" == *.flac ]]; then
		file="${file%.flac}"".opus"
		if [ -e "$opus/$file" ]; then
			echo "$opus/$file already exists"
		else
			#had to set frequency
			#looks like it's unneccessary with opusenc
			opusenc --bitrate "$q" --vbr "$1" "$opus/$file" #--resample 44100
			if [ ! -e "$opus/$file" ]; then
				echo "$opus/$file was not written" >>  "$output"
			fi	
		fi
	#copy album art
	elif [[ "$file" == *.jpg ]]; then
		cp "$1" "$opus/$file"
	fi
}

sub "$flac"
