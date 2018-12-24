#!/bin/bash

# Check out the grp option in X config

kb=` setxkbmap -query | grep layout | awk '{ print $2}'`
if [[ $kb == "$1" ]]; then
	setxkbmap $2
	notify-send "$2" -t 1
elif [[ $kb == "$2" ]]; then
	setxkbmap $1
	notify-send "$1" -t 1
fi
