#!/bin/sh

if ! flock -Fn /tmp/ffmpeg_screencast.lock -c "$(dirname $0)/ffmpeg_screencast.sh"; then
	rm /tmp/ffmpeg_screencast.filename
	pkill -u "$USER" -f "ffmpeg.*x11grab"
fi
