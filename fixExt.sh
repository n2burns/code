#!/bin/bash

#fixExt.sh fixes capitalization of file extensions
# searches through the input folder recursively
# checks file permissions before modifying and temporarily fixes if necessary

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

#checks the current directory recurses if file is a directory
for i in "$dir"/*; do
  if [ -d "$i" ]; then
    ./$0 "$i"
  elif [[ "$i" == *.* ]]; then
    ext=${i##*.}
    low="$(echo $ext | tr '[A-Z]' '[a-z]')"

    if [[ "$ext" != "$low" ]]; then
      out=${i%.*}".$low"
      per=`stat -c %a "$i"`
      echo "$i"
      echo "$out"
      `chmod a+w "$i"`
      `mv "$i" "$out"`
      `chmod $per "$out"`
    fi
  fi
done

