#!/bin/bash
synclient PalmDetect=1 &
synclient PalmMinWidth=5 &
synclient VertEdgeScroll=1 &
synclient HorizEdgeScroll=1 &
synclient TapButton2=3 &
synclient TapButton3=2 &
synclient TapButton1=1 &
syndaemon -t -k -i 2 -d &
