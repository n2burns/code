#!/bin/bash

#name.sh - adds the episode name to well formatted (ie by shit-strip.sh)
# files in a directory. It uses thetvdb.com to achieve this.

#based on info from http://thetvdb.com/wiki/index.php?title=Programmers_API
#TODO write the actual code for this


#get base information for series
#http://www.thetvdb.com/api/2678549BB7CA040A/series/<seriesid>/all/<language>.zip
#make sure we aren't clobbering
#extract <language>.xml from the file
#use 'unzip en.zip en.xml'
#look for the matching season & episode in <DVD_season> & <DVD_episodenumber> 
# if I don't find them, look at <SeasonNumber> and <EpisodeNumber>
# make sure you check for the integer, and integer.0
#maybe instead I should use the basic numbers, as for the most part,
# I'm getting these from aired episodes. I could include a parameter for
# dvd_order? Maybe -d

#extended pattern matching
shopt -s extglob

if [[ $BASH_VERSINFO < 4 ]]; then
  echo "$0 requires bash version to be >=4"
  exit 0
fi

function usage {
  echo "usage: $0 [-i inDir] [-d]"
}

inDir=`pwd`/
dvd_order=false
apikey="2678549BB7CA040A"

file=
seriesname=
seriesid=
season=
episode=
name=
flag=
mythbusters=
ext=

#Uses getops to sort out the arguments
while getops ":di:" opt; do
  case $opt in
    d)
      echo "dvd_order !!"
      dvd_order=true
      ;;
    \?)
      usage
      exit 0
      ;;
    i)
      inDir="$OPTARG"
      echo "We have an input directory of $inDir"
      ;;
    :)
      usage
      exit 0
      ;;
  esac
done

#checks to see if the file matches the pattern for a tv show
# i.e. "name S##E## title.ext" or, if mythbusters "name ### title.ext"
function patt {
  flag=false
  if [[ "$file" == *S?([1-9])@([0-9])E* ]]; then
    flag=true
  fi

  mythbusters=false
  if [[ "$file" == "MythBusters "@([0-9])@([0-9])@([0-9])* ]]; then
    mythbusters=true
  fi
}

#get show id, language (usually 'en' but shouldn't assume)
#could use http://www.thetvdb.com/api/GetSeries.php?seriesname=
#NOTE: what happens if we get the wrong series? No internet/site down??
#the xml file is made up of a <Data> field, then <Series> below that
#if we get no series fields, return an error
#if we get multiple, we can assume that it's the first, becasue that should
# be a perfect match

#Takes the filename and extracts the seriesname
#TODO there should be a step here to convert the show name to
# the one required for thetvdb (eg "Castle" => "Castle (2009)" )
function series {
  if [[ mythbusters ]]; then
    seriesname="MythBusters"
  else
    seriesname="${file%% S?([1-9])@([0-9])E@([0-9])@([0-9])*}"
  fi
}

#get the season & episode
function epiinfo {
  ext="${file%%*.}"
  if [[ mythbusters ]]; then
    episode=
  else
    season="${file%%E@([0-9])@([0-9])*}"
    season="${season%%* S}"
    episode="${file##*S?([1-9])@([0-9])E}"
    episode="${episode:0:2}"
  fi
}

#itterate through the list of files
for i in "$inDir"*; do
  patt
  if !$flag; then
    break
  fi
done
