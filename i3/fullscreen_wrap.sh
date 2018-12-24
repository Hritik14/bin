#!/bin/bash
#++++++++++++++++++++++++++NOT IN USE. ++++++++++++++++++++++++++++= 


# Exits fullscreen 
# executes command
# Re-enters fullsreen
# Inspired by https://github.com/Airblader/dotfiles-manjaro/blob/master/scripts/fullscreen_wrap.sh

# Usage
# fullscreen_wrap.sh command

FOCUSED=`xdotool getactivewindow`
isFullscreen=$(xprop -id $FOCUSED _NET_WM_STATE | grep _NET_WM_STATE_FULLSCREEN)
COMMAND=$*
if [[ $isFullscreen ]]; then
	i3-msg "[id=$FOCUSED]fullscreen disable"
	$COMMAND
	i3-msg "[id=$FOCUSED]fullscreen enable"
else
	$COMMAND
fi
