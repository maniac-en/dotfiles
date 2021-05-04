#!/usr/bin/env bash

set -e -E

cd "$HOME" || exit 1
HERE="$(cd "$(dirname "$0")" && pwd)"

# @@@ list of pre-requisites not complete
# @@@ install commands not tested
# @@@ $package-config.sh are pending
echo "Installing pre-requisites"
sudo pacman -Syyu --noconfirm --needed base-devel git curl xclip cmake ninja
# yay
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd "$OLDPWD" && rm -rf yay
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf && "$HOME"/.fzf/install --no-update-rc --no-completion --no-key-bindings

# symlink all dotfiles to required locations
source config.sh
