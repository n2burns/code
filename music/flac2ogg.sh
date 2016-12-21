#!/bin/bash

#flac2ogg.sh

#This script is designed to keep an up-to-date downscale of all of the flac
#in a library, in ogg format
#
#It itterates through all the files in the flac folder and sees if a
#matching file exists in the ogg folder. If not, it creates a new ogg file using the supplied quality

#quality - oggenc default is 3 which gives a filesize of approximately 10% of FLAC
#q=-1 is the lowest possible value giving a filesize of approx 4.5% of FLAC
#q=0 6.1% of flac

#TODO highlight to the user errors reported by oggenc

function usage {
	echo "usage: $0 flacDir oggDir [quality]"
}

#if args exist, use them. If not, use the supplied data
if [ $# = 2 ]; then
	flac="${1%/}"
	ogg="${2%/}"
	q="0"
elif [ $# = 3 ]; then
	flac="${1%/}"
	ogg="${2%/}"
	q="$3"
else
	usage
	exit 0
fi
output="flac2ogg-`date +%Y%m%d_%H%M%S`.log"

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

#check if output file already exists
#if it doesn't exist, encode it
function encode {
	f="$1"
	file="${f##$flac}"
	file="${file##/}"
	if [ -e "$ogg/$file" ]; then
		echo "$ogg/$file already exists"
	elif [[ "$file" == *.flac ]]; then
		file="${file%.flac}"".ogg"
		if [ -e "$ogg/$file" ]; then
			echo "$ogg/$file already exists"
		else
			#had to set frequency
			oggenc "$1" -q $q -o "$ogg/$file" --resample 44100
			if [ ! -e "$ogg/$file" ]; then
				echo "$ogg/$file was not written" >>  "$output"
			fi	
		fi
	fi
	#copy album art
	if [[ "$file" == *.jpg ]]; then
		cp "$1" "$ogg/$file"
	fi
}

sub "$flac"
