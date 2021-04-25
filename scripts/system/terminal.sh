#!/usr/bin/env bash

bspc desktop -f ^1
wid_t=$(xdotool search --class terminal_fixed)

if [ -z "$wid_t" ]
then
	alacritty --class Alacritty,terminal_fixed -e zsh -c tmux
fi
