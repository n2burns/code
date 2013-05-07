#!/bin/bash
#conkympd.sh - copies albumart.jpg from the directory of the track currently
# playing in MPD to $imageDir as curMPD.jpg. If albumart.jpg does not exist,
# copies /usr/share/pixmaps/sonatacd.png instead

musicDir="/home/n2burns/music"
out="/home/n2burns/tmp/curMPD.jpg"
old=""

while true
do
  #where the album art should be
  art=`mpc -f %file% | head -n 1`
  art="$musicDir"/"${art%/*}"/albumart.jpg

  if [[ "$art" != "$old" ]]; then
    old="$art"
    if [[ -e "$art" ]]; then
      cp "$art" "$out"
#    else
#      convert "/usr/share/pixmaps/sonata-case.png" "$out"
    fi
  fi
  `sleep 1`
done
