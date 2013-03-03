#!/bin/bash

#move.sh - moves files in the given folder to the TV folder

#extended pattern matching
shopt -s extglob

function usage {
	echo "usage: $0 [downDir]"
}

#if args exist, use them. If not, use the supplied data
downDir=`pwd`/
tvDir="/home/n2burns/videos/tv/"
if [[ $# = 1 ]]; then
	#relative paths using $(readlink -f "$1") http://andy.wordpress.com/2008/05/09/bash-equivalent-for-php-realpath/
	downDir=$(readlink -f "$1")/
elif [[ $# > 1 ]]; then
  usage
  exit 0
fi
#output in case of errors
output="/home/n2burns/move`date +%m%d%y`.log"
#Set the name of the weekly folder
monday=$[`date -d monday +%s`-7*24*60*60]
monday=`date -d @$monday +%m%d%y`
monday="$downDir$monday/"
#Store Current Directory and change to downloads folder
curDir=`pwd`
cd "$downDir"

#checks for the correct pattern
function patt {
  flag=false
  if [[ "$file" == *S?([1-9])@([0-9])E* ]]; then
  	flag=true
	fi
}

#checks for mythbuster pattern and then moves it
function mythbusters {
	if [[ "$file" == *"MythBusters "@([0-9])@([0-9])@([0-9])* ]]; then
		year=`date +%Y`
		copy="$tvDir/MythBusters/"`date +%Y`/
		cpmv
	fi
}

#checks that the show name is in the list of shows we already have
#if it is, make this the copy dir
function series {
  flag=false
  s="${ep%% S?([1-9])@([0-9])E@([0-9])@([0-9])*}"
  for j in "${path[@]}"; do
  	f="${j##*/}"
      if [[ "$s" == "$f" ]]; then
				flag=true
				copy="$j"
        break
      fi
  done

  #TODO make this a hash file instead which can be accessed by other scripts?
	#exceptions for shows where the folder and name don't match
	#Castle
	if [[ "$s" == "Castle" ]]; then
		flag=true
	  copy="$tvDir/Castle [2009]"
	fi
	#L&O SVU
	if [[ "$s" == "Law and Order SVU" ]]; then
		flag=true
		copy="$tvDir/Law & Order Special Victims Unit"
	fi
	#Common Law
	if [[ "$s" == "Common Law" ]]; then
		flag=true
	  copy="$tvDir/Common Law [2012]"
	fi
	#Dallas 2012
	if [[ "$s" == "Dallas" ]]; then
		flag=true
	  copy="$tvDir/Dallas [2012]"
	fi
	#The Newsroom 2012
	if [[ "$s" == "The Newsroom" ]]; then
		flag=true
	  copy="$tvDir/The Newsroom [2012]"
	fi
}

function season {
  s=${ep%%E@([0-9])@([0-9])*}
  s=${s##* S}
  if [[ $s -lt 10 ]]; then
    s="0"$s
  fi
  copy="$copy/Season $s/"
}

function cpmv {
  #if season doesn't already exist, create
  if ! [[ -d "$copy" ]]; then
  	mkdir -p "$copy"
  fi
  cp -nv "$file" "$copy"
  if ! [[ -d "$monday" ]]; then
    mkdir "$monday"
  fi
  mv "$file" "$monday"
}

#Show list
x=0
for i in "$tvDir"*; do
  path[$x]="$i"
  (( x++ ))
done

#iterate through the list of files
for i in "$downDir"*; do
	#chmod before anything else
	chmod a+rx "$i"

	file="$i"
  ep="${i##*/}"
	copy=""
	
	patt
	if $flag; then
		series
	else
		mythbusters
	fi

	if $flag; then
		season
	fi

	if $flag; then
		cpmv
	fi
done
cd "$curDir"
