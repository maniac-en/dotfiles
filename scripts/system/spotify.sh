#!/usr/bin/env bash

bspc desktop -f ^5

id_s=($(xdotool search --class "Spotify"))
for id in "${id_s[@]}"
do
	out=$(xprop -id "$id" "_NET_WM_DESKTOP")
	if [ "$out" == "_NET_WM_DESKTOP(CARDINAL) = 4" ]
	then
		xdotool windowmap "$id"
	fi
done
