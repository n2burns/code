#!/bin/bash

# snapraid-auto.sh

# performs shutdown of VM gamma, runs snapraid sync
# (and scrub is run if requested), boots VM gamma
# NOTE because snapraid requires root, this must be run as root.
# There are no sudos in this script

# TODO check running gamma commands as n2burns from root
# TODO email (plus log) snapraid status, SMART status after running
# TODO fix email!

function usage {
	echo "usage: $0 [scrub]"
}
if [ $# = 0 ]; then
	su n2burns -c "gamma shutdown"
	snapraid sync
	su n2burns -c "gamma boot"
elif [ $# = 1 ] && [ $1 == "scrub" ]; then
	su n2burns -c "gamma shutdown"
	snapraid sync
	snapraid scrub
	su n2burns -c "gamma boot"
else
	usage
	exit 0
fi
