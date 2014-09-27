#!/bin/sh
xrandr --output HDMI1 --mode 1280x720 --pos 0x0 --rotate normal --output LVDS1 --mode 1366x768 --pos 1367x0 --rotate normal --output DP1 --off --output VGA1 --off &&
nitrogen --restore &&
conkywonky
