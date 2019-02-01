#!/bin/sh

/usr/bin/logger -t bxc-watchdog "Start bxc-watchdog"

cnt=0
while true; do
	BXC_GATEWAY="fdff:$(ifconfig tun0 | grep fdff | cut -d : -f 3,4,5,6,7,8):1"
	ping6 -c 1 $BXC_GATEWAY
	if [ "$?" != "0" ]; then
		cnt=$((cnt+1))
		/usr/bin/logger -t bxc-watchdog "Lost connection($cnt)!!!"
	fi
	sleep 60
done
