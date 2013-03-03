#!/bin/bash

#filetype.sh
#lists the type of files in the given directory

#check for valid usage
if [ $# != 1 ] && [ $# != 0 ]; then
	echo "filetype.sh [dir]"
	exit 0
fi

#array which holds all extension types
declare -a list

#main function made for recursion through subdirectories
function sub {

	#folder currently being checked
	folder=$1

	#recurse through files
	#go into directories
	#check regular files to see if their ext was included
	for file in "$folder/"*; do
		if [ -d "$file" ]; then
		#	echo "Directory $file"
			sub "$file"
		else
		#	echo "file $file"
			ext "$file"
		fi
	done
}

#check if the ext does not exist in the list
#if the ext DNE, add it to the list
function check {
	bool=true
	for ((i=0;i<${#list[@]};i++)); do
		if [ "$1" == "${list[$i]}" ]; then
			bool=false 
		fi
	done
	if $bool; then
		list[${#list[@]}]=$1
	fi
}


#returns a filename's extension
function ext {
	file="${1##*/}"
	if [[ "$file" == *.* ]]; then
		file="${file##*.}"
		#echo "$file"
		check $file
	fi
}

if [ $# = 1 ]; then
	sub $1
else
	sub .
fi

#Output results
#TODO sort output
echo; echo 'EXT List';echo '========'
for ((i=0;i<${#list[@]};i++)); do
	echo "${list[$i]}"
done
