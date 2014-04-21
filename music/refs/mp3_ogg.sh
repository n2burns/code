#! /bin/bash

echo "this script converts all *.mp3 in current directory to new directory 'mp3_outOGG'"

mkdir mp3_outOGG
for i in *.mp3; do
mv "$i" `echo $i | tr ' ' '_'`
echo $i


#lame -m s -h -b 160 $i -o mp3_outOGG/$i
#mpg321 $i -w raw && oggenc raw -q 7 -o mp3_outOGG/$i

mplayer $i -ao pcm:file=tmp.wav
oggenc tmp.wav -q 7 -o mp3_outOGG/$i.ogg
rm -f tmp.wav

done

#TODO copy id3 tag with id3cp
