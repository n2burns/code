#!/bin/bash

#mkv2mp4.sh

#checks the given folder and subfolders (recursive) and transcodes MKVs to MP4 (without changing the codecs, copying the soft subtitles)

function usage {
        echo "usage: $0 input output"
}

if [ $# = 2 ]; then
	input="${1%/}"
	output="${2%/}"
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

#encode all MKVs to MP4
function encode {
	if [ ${file: -4} == ".mkv" ]; then
		f="$1"
		file="${f##$input}"
		file="${file##/}"
	
		file="${file%.mkv}"".mp4"
		outdir="${file%/*}"
		outdir="$output/$outdir"
		mkdir "$outdir"
		ffmpeg -i "$1" -c copy -c:s mov_text "$output/$file"
	fi
}

sub "$input"
