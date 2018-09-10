#!/bin/bash

# alpha.sh

# perform common VBoxManage actions on VM alpha

# TODO install acpid, follow these instructions
# http://askubuntu.com/questions/66723/how-do-i-modify-the-options-for-the-power-button
# TODO see if we can make the sleep button restart?
# TODO should status be checked or does VBoxManage do that for you?


function usage {
	echo "usage: $0 status|boot|shutdown|restart|pause|resume"
}

if [ $# != 1 ]; then
	usage
	exit 0
else
	case $1 in
		status)
			VBoxManage showvminfo alpha --machinereadable | grep "VMState=";;
		boot)
			VBoxManage startvm alpha --type headless;;
		shutdown)
			VBoxManage controlvm alpha acpipowerbutton;;
		restart)
			VBoxManage controlvm alpha acpisleepbutton;;
		pause)
			VBoxManage controlvm alpha pause;;
		resume)
			VBoxManage controlvm alpha resume;;
		*)
			usage
			exit 0;;
	esac
fi
