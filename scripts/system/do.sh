#!/usr/bin/env bash

sleep 11

# polybar
killall -q polybar # Terminate already running bar instances
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done # Wait until the processes have been shut down
polybar -c "$HOME"/.config/polybar/config.ini myBar -r & # Launch myBar

# picom
kill -s usr1 $(pgrep picom)
picom -b

# redshift
redshift -x
