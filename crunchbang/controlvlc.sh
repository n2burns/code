#!/bin/bash

case $1 in

          next) A="wget -q -t 1 -O - http://127.0.0.1:8080/?control=next" ;;
          prev)  A="wget -q -t 1 -O - http://127.0.0.1:8080/?control=previous" ;;
          play-pause) A="wget -q -t 1 -O - http://127.0.0.1:8080/?control=pause" ;;
          stop) A="wget -q -t 1 -O - http://127.0.0.1:8080/?control=stop" ;;
          *) echo "Usage: $0 { next | prev | play-pause | stop }" ;;

esac

exec $A
