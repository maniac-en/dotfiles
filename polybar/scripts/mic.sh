#!/usr/bin/env bash
if ! hash pactl 2>/dev/null; then exit 1; fi
# pactl list sources | grep -qi 'Mute: yes' && pactl set-source-mute 1 false || pactl set-source-mute 1 true
pactl list sources | grep -qi 'Mute: yes' && printf "%%{F#f00}%%{F-}" || printf ''
