#!/bin/bash

#advTime.sh - rename files in the current folder. They are currently in
#  the format "Adventure Time S#E##[ab] [title].mp4" however, theTVDB.com
#  lists all these episodes separately. I'd prefer theTVDB format

#extended pattern matching
shopt -s extglob

for i in "Adventure Time S"@([0-9])E@([0-9])@([0-9])@([ab])*;
do
  front="${i:0:18}"
  orgE="${i:18:2}"
  char="${i:20:1}"
  title="${i:22}"

  #remove leading 0
  orgE="${orgE#0}"

  #TEST substrings
  #echo "$front|$orgE|$char|$title"

  if [[ $char == a ]]; then
    newE=$[$orgE*2-1]
  else
    newE=$[$orgE*2]
  fi

  #add zero padding back in episode#
  if [ $newE -le 9 ]; then
    newE="0$newE"
  fi
  
  #test output
  #echo "mv $i $front$newE $title"


  `mv "$i" "$front$newE $title"`
done
