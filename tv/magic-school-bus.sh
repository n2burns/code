#!/bin/bash

#magic-school-bus.sh - renumber the stupid magic school bus episodes from
# absolute numbering to season numbering

#extended pattern matching
shopt -s extglob

#changes the episode number from absolute to season
function change {
	episode="${episode##0}"
	let episode=$episode-13*($season-1)
	if [ $episode -lt 10 ]; then
		episode="0"$episode
	fi
	out="$series S$season"E"$episode $name"
}

for i in *;
do
	#itterate through directories
	if [[ -d "$i" ]]; then
		cd "$i"
		#itterate through files in directory
		for j in *;
		do
			file="$j"
			season="${file%%E@([0-9])@([0-9])*}"
			season="${season##* S}"
			episode="${file##* S@([0-9])?([0-9])E}"
			episode="${episode%% *}"
			series="${file%% S?([1-9])@([0-9])E@([0-9])@([0-9])*}"
			name="${file##* S?([1-9])@([0-9])E@([0-9])@([0-9]) }"
			change
			mv "$file" "$out"
		done
		cd ..
	fi
done