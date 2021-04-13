#!/bin/bash

# Source: https://github.com/baskerville/bspwm/issues/291
wid=$1
class=$2
instance=$3
consequences=$4

main() {
    case "$class" in
        Spotify)
            echo "state=fullscreen desktop=5 follow=on"
            ;;
        "")
            sleep 0.1

            wm_class=($(xprop -id $wid | grep 'WM_CLASS' | grep -Po '"\K[^,"]+'))

            class=${wm_class[-1]}

            [[ ${#wm_class[@]} == "2" ]] && instance=${wm_class[0]}

            [[ -n $class ]] && main
            ;;
    esac
}

main
