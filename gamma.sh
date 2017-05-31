#!/bin/bash

# gamma.sh

# perform common VBoxManage actions on VM gamma

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
			VBoxManage showvminfo gamma --machinereadable | grep "VMState=";;
		boot)
			VBoxManage startvm gamma --type headless;;
		shutdown)
			VBoxManage controlvm gamma acpipowerbutton;;
		restart)
			VBoxManage controlvm gamma acpisleepbutton;;
		pause)
			VBoxManage controlvm gamma pause;;
		resume)
			VBoxManage controlvm gamma resume;;
		*)
			usage
			exit 0;;
	esac
fi
