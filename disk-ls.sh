#!/bin/bash

# disk-ls.sh
# Records all the files on all the drives (/media/*) recursively
# By default records to current dir, with optional 

function usage {
  echo "usage: $0 [directory]"
}

out=`pwd`/
if [[ $# = 1 ]]; then
  out=$(readlink -f "$1")/
elif [[ $# > 1 ]]; then
  usage
  exit 0
fi

out=$out"disk-ls-`date +%Y%m%d_%H%M%S`.log"
echo "`find /media/`" >> "$out"
