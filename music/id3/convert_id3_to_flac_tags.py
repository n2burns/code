#!/usr/bin/env python
#A little script to convert ID3 tags, in flac files, to flac tags in the current dir.
#from http://tef.posterous.com/oggenc-doesnt-like-id3-tags-in-flac-files-a-s
'''
Required:
    mutagen
    python-magic
'''

from mutagen.easyid3 import EasyID3
from mutagen.flac import FLAC
import magic,os

#select all flac files with ID3 tags in the current dir
#m = magic.Magic()
for i in os.listdir(os.getcwd()):
    if os.path.isfile(os.path.abspath(i)):
        tmp = magic.from_file(os.path.abspath(i)).split()
        if ("ID3" and "FLAC") in tmp:  #a simple way to find id3 with flac 

        #Now convert all the id3 tags to flac tags
        #EasyID3 just picks the main tags (artist, album, etc) not obscure ones
            id3 = EasyID3(i)
            flac = FLAC(i)
            for key,value in id3.items():
                flac[key] = value


        #delete all the id3 tags from the file and save the flac tags
            id3.delete()
            id3.save()
            flac.save()
