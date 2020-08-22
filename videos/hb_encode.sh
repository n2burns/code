#!/bin/bash

#!hb_encode.sh encode everything in sourcedir and put it in destdir
# solution based on http://www.unix.com/302367123-post2.html

#extended pattern matching
shopt -s extglob

function usage {
  echo "usage: $0 sourceDir destDir"
}

if [[ $# = 2 ]]; then
  sourceDir=$(readlink -f "$1")/
  destDir=$(readlink -f "$2")/
else
  usage
  exit 0
fi


for i in "$sourceDir"/*; do
  #name without folder 
  filename="${i##*/}"
  #check for folders. If a folder is found, recurse on that folder
  if [ -d "$i" ]; then
    mkdir "$destDir"/"$filename"
    ./$0 "$i" "$destDir"/"$filename"
  else
    HandBrakeCLI -i "$i" -o "$destDir/${filename%.*}.m4v" --preset="Android High"
  fi
done
