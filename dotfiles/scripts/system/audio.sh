#!/usr/bin/env bash

# Link for similar script using special character ─ (it's not dash -)
# https://github.com/dastorm/volume-notification-dunst.git

notify="$HOME"/bin/notify2

function send_notification {
    local volume, icon_name
    volume=$(pamixer --get-volume)
    if [ "$volume" == "0" ]; then
        icon_name="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/audio-volume-muted.svg"
    elif [ "$volume" -lt "33" ]; then
        icon_name="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/audio-volume-low.svg"
    elif [ "$volume" -lt "66" ]; then
        icon_name="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/audio-volume-medium.svg"
    else
        icon_name="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/audio-volume-high.svg"
    fi
    $notify "$volume%" -i "$icon_name" -t 2000 --replace=555
}

case $1 in
    up)
        pamixer -u
        pamixer -i 5 --allow-boost
        send_notification
        ;;
    down)
        pamixer -u
        pamixer -d 5 --allow-boost
        send_notification
        ;;
    speaker_mute)
        pamixer -t
        if pamixer --get-mute &>/dev/null ; then
            $notify -i "file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/audio-volume-muted.svg" --replace=555 -u normal "Muted" -t 2000
        else
            send_notification
        fi
        ;;
    mic_mute)
        icon_mute="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/microphone-sensitivity-muted.svg"
        icon_unmute="file:///usr/share/icons/Gruvbox-Material-Dark/24x24/panel/microphone-sensitivity-high.svg"
        pactl set-source-mute 1 toggle
        pactl list sources | grep -qi 'Mute: yes' && \
            $notify -i "$icon_mute" --replace=556 -u normal "Muted" -t 2000 || \
            $notify -i "$icon_unmute" --replace=556 -u normal "Unmuted" -t 2000
        ;;
esac
