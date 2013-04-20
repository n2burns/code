#!/bin/bash

if grep -qs '/media/bigboy ' /proc/mounts; then
  cb-dropbox-pipemenu --start-dropbox
else
  zenity --error --title="MOUNT ERROR" \
    --text="'/media/bigboy' did not mount properly. \nMaybe Windows has been hibernated?"
fi
