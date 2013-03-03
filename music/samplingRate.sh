#!/bin/bash

#samplingRate.sh

#uses mediainfo to put the sampling rate of all the music in the given
#directory into a csv

function usage {
	echo "usage: $0 dir output.csv"
}

if [ $# = 2 ]; then
	dir="$1"
	out="$2"
else
	usage
	exit 0
fi

#clear output
>"$out"

function output {
	echo "$file;"`mediainfo "--Output=Audio;%SamplingRate%" "$file"` >> "$out"
}

#function that itterates through the folders
function sub {
	folder="$1"

	for file in "$folder/"*; do
		if [ -d "$file" ]; then
			sub "$file"
		else
			output
		fi
	done
}

sub "$dir"
