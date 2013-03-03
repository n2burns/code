#!/bin/bash

#warn_poweroff - this script will check if running as root,
# and if so, bring up a pop-up so the user can cancel poweroff

#Check for root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  zenity --info --text="Please run as root"
else

fi


