#!/bin/bash
#
#http://duncanlock.net/blog/2013/08/19/how-to-convert-flac-files-from-24-48-bit-to-16-bit-on-ubuntu-linux/

mkdir resampled
for flac in *.flac; do sox -S "${flac}" -r 44100 -b 16 ./resampled/"${flac}"; done
