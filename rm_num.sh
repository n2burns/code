#!/bin/bash

#rm_rum Removes the track number from the filename of songs
shopt -s extglob
for i in *;
do
  n="${i##+([0-9]) }"
  if [ "$i" != "$n" ]; then
    mv "$i" "$n"
  fi
done
