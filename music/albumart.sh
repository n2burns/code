#!/bin/bash

#albumart.sh

#This script is designed to tell you which music directories have correct and
#incorrect cover art files
#music folders are of the type ~/music/[quality]/[artist]/[album]/
#correct album art will be named albumart.jpg

music="/home/n2burns/music/"

function usage {
	echo "usage: $0"
}

cd "$music"

non_jpg=( jpeg gif tiff png bmp )

#itterate through all jpg files
for i in */*/*/*.jpg; do
	path="$i"
	file=${path##*/}
	if [ "$file" != "albumart.jpg" ]; then
		echo -e "$file\t $path"
	fi
done

#itterate through all files, to find non-jpg pictures
#TODO redo this using search or find
for i in */*/*/*; do
	file="$i"
	ext=${file##*.}
	for j in ${non_jpg[@]}; do
		if [[ "$ext" == "$j" ]]; then
			echo -e "\t $path"
		fi
	done
done

cd "$music"
#itterate through all folders to find those missing album art
for i in */*/*/; do
  cd "$i"
  bool=true
  for j in *; do
    if [[ $j == "albumart.jpg" ]]; then
#     echo "$j is album art"
      bool=false
    fi
  done
  if $bool; then
    echo "$i is missing albumart.jpg!"
  fi
  cd "$music"
done
