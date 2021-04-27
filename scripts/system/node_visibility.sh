#!/usr/bin/env bash

#Source: https://github.com/desyncr/bspwmrc/blob/master/misc/toggle

log_file="$HOME"/.cache/bspwm_node_visibility.log
focused_window="$(xdotool getactivewindow)"

if [ "$?" -eq 0 ]
then
	case "$1" in
		'show')
			if [ -s "$log_file" ]; then
				sed -i '/^$/d' "$log_file"
				xdotool windowmap "$(tail -n 1 "$log_file")"
				sed -i '' -e '$ d' "$log_file"
			else
				"$HOME"/bin/notify2 "Stack empty" -t 1500 -r 234
			fi
			;;
		'hide')
			echo "$focused_window" >> "$log_file"
			xdotool windowunmap "$focused_window"
			;;
	esac
fi
