#!/usr/bin/env bash

buffer=$(clipster -o -n 200 --nul \
    | rofi -font "Comic Code Medium 15" \
    -no-show-icons \
    -i \
    -dmenu \
    -sep '\x00' \
    -width 80 \
    -p "clipboard")

# use new buffer only if not empty, avoid copying empty string to clipboard
if [ ! -z "$buffer" ]
then
    sed -ze 's/\n$//' <<< "$buffer" | xclip -sel clipboard
fi

