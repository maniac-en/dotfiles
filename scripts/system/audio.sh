#!/usr/bin/env bash

# Source: https://github.com/dastorm/volume-notification-dunst.git

notify="$HOME"/bin/notify2

function send_notification {
    volume=$(pamixer --get-volume)
    if [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
        $notify "$volume""      " -i "$icon_name" -t 2000 -h string:synchronous:"─" --replace=555
    else
        if [  "$volume" -lt "10" ]; then
            icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
            $notify "$volume""     " -i "$icon_name" --replace=555 -t 2000
        else
            if [ "$volume" -lt "30" ]; then
                icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
            else
                if [ "$volume" -lt "70" ]; then
                    icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-medium.svg"
                else
                    icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
                fi
            fi
        fi
    fi
    bar=$(seq -s "─" $((volume/5)) | sed 's/[0-9]//g')
    # $notify "$volume""     ""$bar" -i "$icon_name" -t 2000 -h string:synchronous:"$bar" --replace=555
    $notify "$volume%" -i "$icon_name" -t 2000 -h string:synchronous:"$bar" --replace=555
}

case $1 in
    up)
        pamixer -u
        pamixer -i 5
        send_notification
        ;;
    down)
        pamixer -u
        pamixer -d 5
        send_notification
        ;;
    mute)
        pamixer -t
        if pamixer --get-mute &>/dev/null ; then
            $notify -i "/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg" --replace=555 -u normal "Muted" -t 2000
        else
            send_notification
        fi
        ;;
esac
