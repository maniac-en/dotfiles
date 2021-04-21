#!/usr/bin/env bash
# shellcheck disable=SC1079,SC2154,SC1078
set -e

# Picks a file name for the output file based on availability:
dir="$HOME"/screenshots/screencasts
mkdir -p "$dir"

while [[ -f "$dir"/screencast"$n".mkv ]]
do
    n="$((n+1))"
done

filename="$dir"/screencast"$n".mkv
sname="$(basename "$0")"
unset x y w h

# For Pulseaudio with ALSA:
record_pulse() { \
    if [ "$3" -eq 1 ];then
        ffmpeg -y \
        -f x11grab \
        -framerate 60 \
        -s "$1" \
        -i :0.0"$2" \
        -f pulse -i default \
        -r 30 \
        -c:v libx264rgb -crf 0 -preset ultrafast -c:a flac "$filename";
    else
        ffmpeg -y \
        -f x11grab \
        -framerate 60 \
        -s "$1" \
        -i :0.0"$2" \
        -r 30 \
        -c:v libx264rgb -crf 0 -preset ultrafast -c:a flac "$filename" ;
    fi
}

# For ALSA:
record_alsa() { \

    if [ "$3" -eq 1 ];then
        ffmpeg -y \
        -f x11grab \
        -s "$1" \
        -i :0.0"$2" \
        -thread_queue_size 1024 \
        -f alsa -ar 44100 -i hw:1 \
        -c:v libx264 -r 30 -c:a flac "$filename";
    else
        ffmpeg -y \
        -f x11grab \
        -s "$1" \
        -i :0.0"$2" \
        -thread_queue_size 1024 \
        -c:v libx264 -r 30 -c:a flac "$filename";
    fi
}

case "$1" in
    '-s'|'--select'|'select')
        eval "$(xwininfo | sed -n \
            -e 's/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p' \
            -e 's/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p' \
            -e 's/^ \+Width: \+\([0-9]\+\).*/w=\1/p' \
            -e 's/^ \+Height: \+\([0-9]\+\).*/h=\1/p' )"

        w=$((w + w % 2))
        WIN_XY=+"$x","$y"
        WIN_GEO="$w"x"$h"

        if [ "$2" == '-a' ]; then
            if [[ $(pgrep -x pulseaudio) ]]; then record_pulse "$WIN_GEO" "$WIN_XY" 1; else record_alsa "$WIN_GEO" "$WIN_XY" 1; fi
        else
            if [[ $(pgrep -x pulseaudio) ]]; then record_pulse "$WIN_GEO" "$WIN_XY" 0; else record_alsa "$WIN_GEO" "$WIN_XY" 0; fi
        fi

        ;;

    '-f'|'--full'|'full')

        if [ "$2" == '-a' ] || [ "$2" == '--audio' ] || [ "$2" == 'audio' ]; then
            if [[ $(pgrep -x pulseaudio) ]]; then record_pulse "$(xdpyinfo | grep dimensions | awk '{print $2;}')" "" 1; else record_alsa "$(xdpyinfo | grep dimensions | awk '{print $2;}')" "" 1; fi
        else
            if [[ $(pgrep -x pulseaudio) ]]; then record_pulse "$(xdpyinfo | grep dimensions | awk '{print $2;}')" "" 0; else record_alsa "$(xdpyinfo | grep dimensions | awk '{print $2;}')" "" 0; fi
        fi

        ;;
    ''|'-h'|'--help'|'help')

        echo -e """Capture screencasts with/without audio - compatible with both ALSA and PULSEAUDIO
\nUsage: ""$sname"" command [option]
\nAvailable commands:
    -s or --select or select : select a window to capture it
    -f or --full or full     : capture full screen
    -h or --help or help     : see this help menu
\nAvailable options:
    -a or --audio or audio   : record audio with screencasts
\nExample usage:
     ""$sname"" -s        : Capture the selected window
     ""$sname"" -s -a     : Capture the selected window with audio
     ""$sname"" -f        : Capture full-screen
     ""$sname"" -f -a     : Capture full-screen with audio"""
        ;;
esac
exit 0
