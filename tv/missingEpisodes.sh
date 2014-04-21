#!/bin/bash

#missingEpisodes.sh - looks through the cur dir for missing episodes.
# If no show name is given, assumes the first file it finds is correct.
# Returns those episodes which are missing as well as the first
# and last episode number for the show.

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
	episode=${k##*S+([0-9])E}
	episode=${episode:0:2}
	episode=${episode##0}
}

function getSeries {
  series=${k%% S+([0-9])*}
}

function getSeason {
	season=${k%%E+([0-9])*}
	season=${season##*S}
}

#gets the next episode
function getNext {
  next=$[episode+1]
	if [[ $next -lt 10 ]]; then
	  next="0$next"
	fi
}

#sets the last episode in the current season
function getCurSLastE {
  curSLastE=`ls "$series S$season"* | sort -n | tail -1`
  curSLastE=${curSLastE##*S+([0-9])E}
  curSLastE=${curSLastE:0:2}
  curSLastE=${curSLastE##0}

}

#sets the last season in the folder
function getLastS {
  lastS=`ls "$series "* | sort -n | tail -1`
	lastS=${lastS%%E+([0-9])*}
	lastS=${lastS##*S}
}

getSeries
getSeason
getEpisode

