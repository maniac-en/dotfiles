#!/usr/bin/env bash

# bspwm
rsync -r --delete "$HOME"/.config/bspwm "$PWD"

# rofi
rsync -r --delete "$HOME"/.config/rofi "$PWD"

# sxhkd
rsync -r --delete "$HOME"/.config/sxhkd "$PWD"

# polybar
rsync -r --delete "$HOME"/.config/polybar "$PWD"

# picom
rsync -r "$HOME"/.config/picom.conf "$PWD"/picom/

# pcmanfm
rsync -r --delete "$HOME"/.config/pcmanfm "$PWD"

# alacritty
rsync -r --delete "$HOME"/.config/alacritty "$PWD"

# clipster
rsync -r --delete "$HOME"/.config/clipster "$PWD"

# zsh
rsync -r "$HOME"/.zshrc "$PWD"/zsh/
rsync -r --delete "$HOME"/.zsh "$PWD"/zsh/
rsync -r --delete "$HOME"/.zsh_functions "$PWD"/zsh/

# vim
rsync -r "$HOME"/.vimrc "$PWD"/vim/
rsync -r --delete "$HOME"/.vim "$PWD"/vim/

# tmux
rsync -r "$HOME"/.tmux.conf "$PWD"/tmux/

# zathura
rsync -r --delete "$HOME"/.config/zathura "$PWD"

# screenkey
rsync -r "$HOME"/.config/screenkey.json "$PWD"/screenkey/

# neofetch
rsync -r --delete "$HOME"/.config/neofetch "$PWD"

# GTK theme
rsync -rl --delete "$HOME"/.themes/ "$PWD"/gtk/
rsync -r --delete "$HOME"/.config/gtk-3.0 "$PWD"/gtk/
