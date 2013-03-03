#!/bin/bash

#albumart.sh

#This script is designed to tell you which leaf directories in the given
#directory do not contain exactly one jpg file. It will also notify the user if
#non-jpg files are present.
#The purpose of this script is to alert the user where they have no cover art,
#more than one cover art file, or cover art in non-jpg formats

function usage {
	echo "usage: $0 dir"
}

if [ $# = 1 ]; then
	dir="${1%/}"
else
	usage
	exit 0
fi

non_jpg=( jpeg gif tiff png bmp )

#function that itterates through the folders
function sub {
	folder="$1"
	leaf=true
	for file in "$folder/"*; do
		leaf=false
		if [ -d "$file" ]; then
			sub "$file"
		fi
	done
	if $leaf; then
		check "$folder"
	fi
}

#outputs if any of the files are non_jpg
function non {
	file="$1"
	ext=${file##*.}
	for j in $non_jpg; do
		if [[ $j == $ext ]]; then
			echo "  X $file"
		fi
	done
}

function check {
	leaf="$1"
	count=0
	for i in "$leaf/"*; do
		if [[ $i == *.jpg ]]; then
			((count++))
		fi
	done
}


sub "$dir"