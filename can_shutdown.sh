#!/bin/sh
# Auto Shutdown Timer Linux - Simple
# Author: nubuntu
# Send feedback to ohbuntu@gmail.com
# Homepage: http://ohbuntu.blogspot.com

ans=$(zenity  --list  --width 300 --title "Auto Shutdown Timer [ Abort ]" --text "Abort shutdown timer?" --radiolist  --column "" --column "Option"  option1 "Abort" option2 "Continue shutdown");
if [ "$ans" = "Abort" ]; then 

  PASSWORD=`zenity --title='Auto Shutdown Timer [ Abort ]' --text='Please enter your password. Shutdown timer will continue if invalid password entered' --entry --hide-text`
  echo $PASSWORD | sudo -S shutdown -c 

else 
  zenity --info --timeout=10 --text "Shutdown timer still in progress!" --title "Auto Shutdown Timer"
fi
