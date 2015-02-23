#!/bin/bash

#folders.sh - moves videos from subdirectories and puts them in the root
# folder
#Only goes down one level, but could easily be modified to be recursive

rootDir=`pwd`

function usage {
	echo "usage: $0 [directory]"
}

if [[ $# = 1 ]]; then
	rootDir=$(readlink -f "$1")/
elif [[ $# > 1 ]]; then
	usage
	exit 0
fi


cd "$rootDir"
for i in */;
do
	cd "$i"
	mv *.mp4 "$rootDir"
	cd "$rootDir"
	rm "$i" -r
done
