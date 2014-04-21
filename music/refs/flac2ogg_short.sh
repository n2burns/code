#!/bin/bash
#flac2ogg_short.sh

#Given an artist folder (artist/album/songs.flac) makes .ogg files,
#moves those to the output directory (keeping hierchy), copies jpg/jpeg covers

#TODO credit following few lines
# helper function to exit with a message
die(){
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
        Q="$3"
fi

#input directory, output directory and quality
cd "$2"
ogg=`pwd`
cd -
cd "$1"
flac=`pwd`

oggenc -q $Q */*.flac
for i in *
do
	mkdir "$ogg/$i"
	mv "$i"/*.ogg "$ogg/$i"
	cp "$i"/*.jpg "$i"/*.jpeg "$ogg/$i"
done

