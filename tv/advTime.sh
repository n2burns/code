#!/bin/bash

#advTime.sh - rename files in the current folder. They are currently in
#  the format "Adventure Time S#E##[ab] [title].mp4" however, theTVDB.com
#  lists all these episodes separately. I'd prefer theTVDB format

#xtended pattern matching
shopt -s extglob

for i in "Adventure Time S"*;
do
  front="${i:0:18}"
  orgE="${i:18:3}"
  title="${i:21}"
  echo "$file|$orgE|$title"
done
