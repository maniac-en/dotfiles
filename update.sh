#!/usr/bin/env bash

# alacritty
rsync -r --delete "$HOME"/.config/alacritty "$PWD"

# bspwm
rsync -r --delete "$HOME"/.config/bspwm "$PWD"

# clipster
rsync -r --delete "$HOME"/.config/clipster "$PWD"

# dunst
rsync -r --delete "$HOME"/.config/dunst "$PWD"

# gtk theme
rsync -rl --delete "$HOME"/.themes/ "$PWD"/gtk/
rsync -r --delete "$HOME"/.config/gtk-3.0 "$PWD"/gtk/

# neofetch
rsync -r --delete "$HOME"/.config/neofetch "$PWD"

# pcmanfm
rsync -r --delete "$HOME"/.config/pcmanfm "$PWD"

# picom
rsync -r "$HOME"/.config/picom.conf "$PWD"/picom/

# polybar
rsync -r --delete "$HOME"/.config/polybar "$PWD"

# rofi
rsync -r --delete "$HOME"/.config/rofi "$PWD"

# screenkey
rsync -r "$HOME"/.config/screenkey.json "$PWD"/screenkey/

# scripts
rsync -r --delete "$HOME"/scripts "$PWD"

# sxhkd
rsync -r --delete "$HOME"/.config/sxhkd "$PWD"

# tmux
rsync -r "$HOME"/.tmux.conf "$PWD"/tmux/

# vim
rsync -r "$HOME"/.vimrc "$PWD"/vim/
rsync -r --delete "$HOME"/.vim "$PWD"/vim/

# zathura
rsync -r --delete "$HOME"/.config/zathura "$PWD"

# zsh
rsync -r "$HOME"/.zshrc "$PWD"/zsh/
rsync -r --delete "$HOME"/.zsh "$PWD"/zsh/
rsync -r --delete "$HOME"/.zsh_functions "$PWD"/zsh/
