#!/bin/bash

#!hb_encode.sh encode everything in sourcedir and put it in destdir
# solution based on http://www.unix.com/302367123-post2.html

sourcedir="/home/n2burns/videos/tv/Adventure Time - Seasons 1-3 Complete [720p] x264.mp4/Adventure Time - Season 1"
destdir="/home/n2burns/videos/N1/Adventure Time/Season 01"
cd "$sourcedir"
for i in *; do
  HandBrakeCLI -i "$i" -o "$destdir/${i%.*}.m4v" --preset="Android High"
done
