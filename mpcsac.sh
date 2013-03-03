#!/bin/bash

# mpcsap.sh - Uses mpc to stop mpd after current track
# comes from http://mpd.wikia.com/wiki/Hack:stop_after_current
sleep $(mpc | awk -F"[ /:]" '/playing/ {print 60*($8-$6)+$9-$7}');mpc pause
