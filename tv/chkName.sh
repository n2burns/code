#!/bin/bash

#chkName.sh - checks the filenames and returns filename
#  if it doesn't match the standard naming for TV
#    (show) S(season)E(epi)[-epi] (episode name).(ext)
#  searches recursively through the inputted directory

#extended pattern matching
shopt -s extglob

function usage {
echo "usage: $0 [directory]"
}

dir=`pwd`/
if [[ $# = 1 ]]; then
  dir=$(readlink -f "$1")/
elif [[ $# > 1 ]]; then
  usage
  exit 0
fi

#checks the current directory - recurses if file is a directory
for i in "$dir"/*; do
  if [ -d "$i" ]; then
    ./$0 "$i"
  elif [[ "$i" != *" "S?([0-9])@([0-9])E@([0-9])@([0-9])?(-[0-9])?([0-9])" "*.* ]]; then
    echo "$i"
  fi
done
