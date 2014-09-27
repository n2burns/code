#!/bin/bash

#missingEpisodes.sh - looks through the cur dir for missing episodes.
# If no show name is given, assumes the first file it finds is correct.
# Returns those episodes which are missing as well as the first
# and last episode number for the show.

#TODO add ability to find double/triple/etc episodes
# before getting the next episode, should check current file name
# to see if there is a '-' after the episode number

#TODO check sub-dirs

#TODO check through multiple TV shows

#TODO check for fully missing seasons

#extended pattern matching
shopt -s extglob

#output running commands. Test line
#set -x

function usage {
  echo "usage: $0 [file]"
}

#if a file is provided, used that file as the initial file. 
# If not provided, use first file in alphanumerical order
file=`ls | sort -n | head -1`
if [[ $# = 1 ]]; then
  file="$1"
elif [[ $# > 1 ]]; then
  usage
  exit 0
fi


function getEpisode {
	episode=${file##*S+([0-9])E}
	episode=${episode:0:2}
	#episode=${episode##0}
}

function getSeries {
  series=${file%% S+([0-9])*}
}

function getSeason {
	season=${file%%E+([0-9])*}
	season=${season##*S}
}

#gets the next episode
function getNext {
  if [[ $episode = $curSLastE ]]; then
    echo "Last episode of season - $series S"$season"E$episode"
    (( season++ ))
    getCurSLastE
    episode="01"
  else
    episode=${episode##0}
    (( episode++ ))
    if [[ $episode -lt 10 ]]; then
      episode="0$episode"
    fi
  fi
}

#sets the last episode in the current season
function getCurSLastE {
  curSLastE=`ls "$series"\ S$season* | sort -n | tail -1`
  curSLastE=${curSLastE##*S+([0-9])E}
  curSLastE=${curSLastE:0:2}
  curSLastE=${curSLastE##0}

}

#sets the last season in the folder
function getLastS {
  lastS=`ls "$series"* | sort -n | tail -1`
	lastS=${lastS%%E+([0-9])*}
	lastS=${lastS##*S}
}

#checks the current episode for DNE. Recurs if not last episode
function check {
  if ! [ -e "$series S$season"E"$episode"* ]; then
    echo "  Missing $series "S"$season"E"$episode"
  fi

  if ! [[ $episode = $curSLastE ]] || ! [[ $season = $lastS ]]; then
    getNext
    check
  else
    echo "Last episode - $series S"$season"E$episode"
  fi
}

getSeries
getSeason
getEpisode

getCurSLastE
getLastS

echo "First episode - $series S"$season"E$episode"
check
