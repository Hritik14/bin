#!/bin/bash

# Suspending/Saving all vms [If open, except Google Devices (Androids)]
vboxmanage list runningvms| grep -v Google | while read line; do
	vm=`echo "$line"|cut -d\" -f2`
	nid=`notify-send -p -t 100000000 "$vm" Suspending`
	vboxmanage controlvm "$vm" savestate
	notify-send -r $nid "$vm" "Suspended and saved"
done

# Security, duh!
if `pgrep xss-lock`;then
	i3lock&
	sleep 1
fi

if [ "$1" = "hibernate"  ]; then
	# Fuck firefox
	# Not now
#	pkill firefox
	systemctl hibernate
elif [ "$1" = "suspend" ]; then
	systemctl suspend
elif [ "$1" = "shutdown" ]; then
	systemctl poweroff
elif [ "$1" = "reboot" ]; then
	systemctl reboot
fi
