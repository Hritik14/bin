#!/bin/sh
#Record with ffmpeg and keep updating i3blocks

file=$HOME/Videos/screencast/$(date +%s).mp4
echo "$file">/tmp/ffmpeg_screencast.filename

ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i "$DISPLAY".0+0,0 \
	-f pulse -i "alsa_input.pci-0000_00_1f.3.analog-stereo"\
	-f pulse -ac 2 -i "alsa_output.pci-0000_00_1f.3.analog-stereo.monitor"\
	"$file" & pid=$!
    -preset veryfast \

while kill -0 "$pid"; do
	pkill -xu "$USER" -RTMIN+4 i3blocks
	sleep 2
done

pkill -xu "$USER" -RTMIN+4 i3blocks
