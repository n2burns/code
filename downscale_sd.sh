#/bin/bash
  
#downscale_sd.sh

#search for videos in input folder that are larger than 480p, move the orginal
#to backup, and resize to 480p

function usage {
        echo "usage: $0 Dir"
}

if [ $# = 1 ]; then
	orgDir="${1%/}"
else
	usage
	exit 0
fi

#TODO find files bigger than 480p and makes backup
#TODO determine how much the files need to be scaled
#TODO output if a file doesn't fit into a specified range 720p (700-740),
#     1080 (1000-1150)
#TODO use ffmpeg to scale files
