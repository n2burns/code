#!/bin/bash

#quick-strip.sh - to shit strip TV files before they get renamed
# this one only does basic stripping
# it finds "HDTV" in the name, replaces all "." before with " "
# and removes "hdtv" and everything else up to the .ext

curDir=`pwd`

function usage {
	echo "usage: $0 [directory]"
}

#if args exist, use them. If not, use the supplied data
downDir=`pwd`/
if [[ $# = 1 ]]; then
        downDir=$(readlink -f "$1")/
elif [[ $# > 1 ]]; then
        usage
        exit 0
fi


cd "$downDir"
for i in *;
do
	#from tv shows that match pattern
	if [[ "$i" == *HDTV* ]]; then
		#split string into basic name and file ext
		#front has has (.)HDTV* removed
		#   as well as if the show name has the year or "US"
		#   at the end
		front=${i%%HDTV.*}
		front=${front%%.}
		front=${front%%.US}
		front=${front%%.`date +%Y`}
		front=${front%%.US}
		ext=${i##*.}

		#replace every "." in the file name with " "
		name=${front//./" "}

		mv "$i" "$name.$ext"
		i="$name.$ext"
	fi

	#removes zero-padding
  if [[ "$i" == *" S0"* ]]; then
    show=${i%% S0*}
    end=${i##*S0}

    mv "$i" "$show S$end"
  fi


done
cd "$curDir"
