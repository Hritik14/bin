#!/bin/bash
#usage toggle.sh WHAT

if [  $# -ne 2 ]; then
	echo "Usage $0 WHAT"
fi

case "$1" in 
	"ffmpeg_screencast")
		if ! flock -Fn /tmp/ffmpeg_screencast.lock -c "$(dirname "$0")/ffmpeg_screencast.sh"; then
			rm /tmp/ffmpeg_screencast.filename
			pkill -u "$USER" -f "ffmpeg.*x11grab"
		fi
		;;
	"logkeys") #Make it based on return value off llk once aur is updated
		if pgrep -x logkeys; then
			echo "Killing"
			llkk
		else
			echo "Starting"
			llk
		fi
		;;
	"monitor") # Requires monitor name as $2
		mod="/home/$USER/bin/i3/toggle-monitor.sh"
		if [[ ! -x "$mod" ]]; then
			echo "toggle-monitor.sh module not installed"
			exit 1
		fi
		$mod $2
		;;
esac
