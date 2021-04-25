#!/usr/bin/env bash

function _get_vol() {
	volume=$(pamixer --get-volume)
	if pamixer --get-mute &>/dev/null
	then
		echo "%{F#f00} Muted%{F-}"
	elif [ "$volume" = "0" ]
	then
		echo "%{F#f00} Muted%{F-}"
	else
		echo " $volume%"
	fi
}

_get_vol
