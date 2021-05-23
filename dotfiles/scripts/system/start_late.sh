#!/usr/bin/env bash

if ! hash bashtop dmidecode picom redshift 2>/dev/null; then exit 1; fi

sleep 11

# polybar
# killall -q polybar # Terminate already running bar instances
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done # Wait until the processes have been shut down
# polybar -c "$HOME"/.config/polybar/config.ini myBar -r & # Launch myBar

# picom
if (sudo dmidecode | grep -A3 '^System Information' | grep -qi 'virtual'); \
then true; else kill -s usr1 $(pgrep picom); picom -b; fi

# redshift : save my aging eyes
redshift -x && redshift -O 5800K
