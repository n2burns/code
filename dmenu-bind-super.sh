#!/bin/bash
exe=`dmenu_path | dmenu -b -nb '#ff0000' -nf '#d8d8d8' -sb '#d8d8d8' -sf '#ff0000'` && eval "exec gksudo $exe"
