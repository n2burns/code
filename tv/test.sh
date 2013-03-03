#!/bin/bash

#extended pattern matching
shopt -s extglob

function usage {
        echo "usage: $0 [directory]"
}

monday=$[`date -d monday +%s`-7*24*60*60]
monday=`date -d @$monday +%m%d%y`
echo $monday


declare -A hash
hash=(["Castle"]="Castle [2009]" ["Law & Order SVU"]="Law & Order Special Victims Unit")

function toSeries {
	if [[ "${hash[$show]}" ]]; then
		echo "X ${hash[$show]}"
	else
		echo "Y $show"
	fi
}
echo ""
show="Law & Order SVU"
toSeries
show="Castle"
toSeries
show="How I Met Your Mother"
toSeries
