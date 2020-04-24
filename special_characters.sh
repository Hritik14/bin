#!/bin/bash
# Creates a menu of special characters via dmenu or rofi. Once a character is
# selected, it is pasted to the cursor via xdotool. Symbols can be added to the
# menu on the character_list with any keyword, but make sure to keep the syntax
#
# syntax: 
#     keyword    :$symbol
#
# $symbol will be the character printed via xdotool. Anything between the
# colon and the \n (linebreak) will be pasted, excluding trailing whitespace.
#
# note1: By modifying 'sep', a different character rather than colon could be
# used, in case some of the symbols used have colons in them. For my
# purpose, this has never been the case.
#
# note2: The xdotool is given a delay because of issues I've had with printing
# long smileys, this could be removed if only single-character symbols are
# desired, and it may improve the experience.
#
# Script Created By: https://github.com/mbfraga Feel free to do anything you
# want with this script.

launcher="rofi" # dmenu/rofi
character_list="files/special_characters_list files/font-awesome_list"
sep=":"

cd "$(dirname "$0")" || exit

if [ $# -gt 0 ]; then
   if [ "$1" == "-d" ]; then
      launcher="dmenu"
   elif [ "$1" == "-r" ]; then
      launcher="rofi"
   fi
fi


if [ "$launcher" == "dmenu" ]; then
   if ! (command -v dmenu 2>/dev/null); then
      echo "dmenu not installed, trying rofi..."
      if command -v rofi 2>/dev/null; then
         launcher=rofi
      else
         echo "rofi not installed either, aborting..."
         exit 1
      fi
   fi
fi

if [ "$launcher" == "rofi" ]; then
   if ! (command -v rofi 2>/dev/null); then
      echo "dmenu not installed, trying dmenu..."
      if command -v dmenu 2>/dev/null; then
         launcher=dmenu
      else
         echo "dmenu not installed either, aborting..."
         exit 1
      fi
   fi
fi


_rofi () {
	# Stolen from Arch Wiki
	cat $1 | column -s "$sep" -o "$sep" -t | rofi -dmenu  \
		 -lines 2 -line-margin 0 -line-padding 1 \
		 -separator-style none -font "mono 20" \
		 -cache-dir ~/.cache/special_characters \
		 -hide-scrollbar \
		 -color-window "#222222, #222222, #b1b4b3" \
		 -color-normal "#222222, #b1b4b3, #222222, #005577, #b1b4b3" \
		 -color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
		 -color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
		 -kb-row-select "Tab" -kb-row-tab "" \
		 -matching fuzzy \
		 -p "symbols" \
		 -l 10 -async-pre-read 10 \
		 -location 0 -width 50

}

_dmenu () {
   cat $1 | dmenu -l 10 -p "symbols:" -fn "Monospace-22"
}


if [ "$launcher" == "dmenu" ]; then
	selected_string=$(_dmenu "$character_list")
elif [ "$launcher" == "rofi" ]; then
	selected_string=$(_rofi "$character_list")
fi

selected_symbol=$(cut -d "$sep" -f 2 <<< "$selected_string")
#trim whitespace
selected_symbol=${selected_symbol// }

xdotool type  "$selected_symbol"
