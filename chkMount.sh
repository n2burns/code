#!/bin/bash

if grep -qs '/media/windows ' /proc/mounts; then
  cb-dropbox-pipemenu --start-dropbox
else
  zenity --error --title="MOUNT ERROR" \
    --text="'/media/windows' did not mount properly. \nMaybe Windows has been hibernated?"
fi
