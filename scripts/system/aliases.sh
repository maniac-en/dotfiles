#!/bin/bash

cat "$HOME"/.zsh/aliases.zsh |
    rofi -dmenu -i -markup-rows -no-show-icons -width 1400 -lines 15 -p "aliases"
