#!/usr/bin/env bash
if [ -s "$HOME"/.cache/bspwm_node_visibility.log ];then
    "$HOME"/bin/notify2 "BSPWM" "Some nodes are still hidden.\nQuit/Kill them to continue!" -t 2000 -r 213
else
    bspc wm -r && pkill -USR1 -x sxhkd
fi
