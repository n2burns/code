#!/bin/bash
#TODO go through TV files and check for completeness
tvDir=/home/n2burns/Videos/TV/
#setting to allow full pattern matching
shopt -s extglob

#returns episode#
function getEpisode {
	episode=${k##*S+([0-9])E}
	episode=${episode:0:2}
	episode=${episode##0}
}

function getSeries {
	series=${k%% S+([0-9])*}
}

function getSeason {
	season=${k%%E+([0-9])*}
	season=${season##*S}
}

function getNext {
	next=$[episode+1]
	if [[ $next -lt 10 ]]; then
		next="0$next"
	fi
}
function check {
	getSeries
	getSeason
	getEpisode
	getNext
	if ! [ -e "$series "S"$season"E"$next"* ]; then
		count=$[count+1]
		echo "  Missing $series "S"$season"E"$next"
	fi
}


cd "$tvDir"
#ittertate through shows
for i in *; do
	cd "$i"
	#ittertate through seasons
	for j in *; do
		cd "$j"
		count=0
		#itterate through episodes
		for k in *; do
			check
		done
		if [[ count>1 ]]; then
			echo "Check $series "S"$season"
		fi
		cd ..
	done
	cd ..
done