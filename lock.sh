#!/bin/bash
#Credit: https://github.com/petvas/i3lock-blur
TMPBG=/tmp/screen.png
RES=1920x1080
 
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -vf "gblur=20:1" -vframes 1 $TMPBG 
i3lock -tui $TMPBG
rm $TMPBG
