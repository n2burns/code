#!/bin/bash

#albumart-missing.sh Testing a script to find music folders missing album art

music="/home/n2burns/music/"

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

