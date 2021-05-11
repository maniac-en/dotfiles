#!/usr/bin/env bash
if [ -s "$HOME"/.cache/bspwm_node_visibility.log ]
then
    "$HOME"/bin/notify2 "BSPWM" "Some nodes are still hidden.\nQuit/Kill them to continue!" -t 2000 -r 213
else
	read -rp "Did you turn off the mic? " mic
	read -rp "Did you unplug the charger? " charger
	if [ "$mic" == "done" ] && [ "$charger" == "done" ]
	then
		shutdown now
	else
		echo "Just do the fu**** thing and try again!"
	fi
fi
