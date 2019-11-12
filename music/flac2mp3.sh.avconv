#!/bin/bash

#flac2mp3.sh

#Encodes all .flac in input directory to mp3 in the output directory


function usage {
	echo "usage: $0 flacDir mp3Dir"
}

if [ $# = 2 ]; then
	flac="${1%/}"
        mp3="${2%/}"
else
	usage
	exit 0
fi

#function that itterates through the folders
function sub {
        folder="$1"

        for file in "$folder/"*; do
                if [ -d "$file" ]; then
			#check if output directory exists. If not, create it
			if [[ ! -d "$mp3/${file##$flac}" ]]; then
				mkdir -p "$mp3/${file##$flac}"
			fi
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
	if [ -e "$mp3/$file" ]; then
		echo "$mp3/$file already exists"
	elif [[ "$file" == *.flac ]]; then
		file="${file%.flac}"".mp3"
		if [ -e "$mp3/$file" ]; then
			echo "$mp3/$file already exists"
		else
			echo "avconv -i $1 $mp3/$file"
			avconv -i "$1" "$mp3/$file"
			if [ ! -e "$mp3/$file" ]; then
                                echo "$mp3/$file was not written" >>  "$output"
			fi
		fi
        #copy album art
        elif [[ "$file" == *.jpg ]]; then
		cp "$1" "$mp3/$file"	
	fi
}

sub "$flac"
