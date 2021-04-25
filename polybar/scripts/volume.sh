#!/usr/bin/env bash

function _get_vol() {
	volume=$(pamixer --get-volume)
	if pamixer --get-mute &>/dev/null
	then
		echo " Muted"
	elif [ "$volume" = "0" ]
	then
		echo " Muted"
	else
		echo " $volume%"
	fi
}

_get_vol
