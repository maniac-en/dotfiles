#!/usr/bin/env bash

bspc desktop -f ^9

id_s=($(xdotool search --class "Discord"))
for id in "${id_s[@]}"
do
	out=$(xprop -id "$id" "_NET_WM_DESKTOP")
	if [ "$out" == "_NET_WM_DESKTOP(CARDINAL) = 8" ]
	then
		xdotool windowmap "$id"
	fi
done
