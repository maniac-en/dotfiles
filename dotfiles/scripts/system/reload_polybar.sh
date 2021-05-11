#!/usr/bin/env bash
if ! hash polybar 2>/dev/null; then exit 1; fi

killall -q polybar # Terminate already running bar instances
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done # Wait until the processes have been shut down
polybar -c "$HOME"/.config/polybar/config.ini myBar -r & # Launch myBar
