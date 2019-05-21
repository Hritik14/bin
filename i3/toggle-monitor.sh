#!/bin/bash

# $1 = monitor's name

# Defaults 
case "$1" in 
	"eDP-1")
		pos="--right-of HDMI-1"
		;;
	"HDMI-1")
		pos="--left-of eDP-1"
		;;
esac

if xrandr --listactivemonitors | grep "$1"; then #it's on
	xrandr --output "$1" --off
else #it's off
	xrandr --output "$1" --auto
	xrandr --output "$1" $pos
fi
