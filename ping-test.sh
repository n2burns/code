#!/bin/sh
 
# ping-test.sh
# Will test for connectivity, and if not able to ping Google DNS, will
# Run openvpn-restart


# ORG SOURCE - http://jeromejaglale.com/doc/unix/shell_scripts/ping
# -q quiet
# -c nb of pings to perform
 
ping -q -c5 google.com > /dev/null
 
if [ $? -eq 0 ]
then
	openvpn-restart
#	echo "ok"
fi
