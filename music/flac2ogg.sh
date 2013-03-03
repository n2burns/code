#!/bin/bash

#	flac2ogg.sh:	a small script to convert a bunch of FLAC files to
#					OGG/Vorbis
#
#	Copyright (C) 2005, Daniel Schregenberger (npfdd{insert@here}gmx.net)
#
#	License: GPL
#
#	Version 0.1 - Initial Release

# define a dir where temporary files may be stored
DIR="/tmp"

# helper function to exit with a message
die(){
	cat <<-EOF
		$@
	EOF
	exit 1
}

usage() {
	echo "usage: $0 flacdir oggdir [quality]"
}

# basic tests
if [ -z "$1" ]; then
	usage
	die "no flac directory specified"
fi
if [ -z "$2" ]; then
	usage
	die "no ogg directory specified"
fi
if [ -z "$3" ]; then
	Q=""
else
	Q="-q$3"
fi

# basic assignments
FLACDIR="$1"
OGGDIR="$2"

# loop over a specified directory
iterate() {
	prefix=$1
	action=$2

	ls "$FLACDIR/$prefix" | while read flacfile ; do
		$action "$prefix" "$flacfile"
		
		# test for exit status of action
		if [ "$?" = "1" ]; then
			exit 1
		fi
		
		prefix=$1
	done
	
	# test for exit status of the loop
	if [ "$?" = "1" ]; then
		exit 1
	fi
}

encode() {
	prefix=$1
	flacfile=$2
	
	# omit directories
	if [ -d "$FLACDIR/$prefix/$flacfile" ]; then
		echo "entering directory $flacfile ..."
		mkdir -p "$OGGDIR/$prefix/$flacfile"
		iterate "$prefix/$flacfile" "encode"
		echo "leaving directory $flacfile ..."
		echo
	else
		oggfile=$(echo "$flacfile" | sed -e 's/.flac$/.ogg/')
		
		# omit existing files
		if [ -f "$OGGDIR/$prefix/$oggfile" ]; then
			continue
		fi

		# only encode flac files
		f=`echo "$flacfile" | grep "flac$"`
		if [ -z "$f" ]; then
			continue
		fi

		# create ogg file
		oggenc $Q -o "$OGGDIR/$prefix/$oggfile" "$FLACDIR/$prefix/$flacfile"
	fi
}

echo "encoding ..."
iterate "" "encode"
