#!/usr/bin/env bash

# @@@ need to fix font issue for comic code
# @@@ need to find a port .env.api securely
# @@@ check why spotify.sh bugs out in polybar
# @@@ automate locale gen
# @@@ config custom compdefs

set -e -E

CONFIG_DIR="$HOME"/.config
mkdir -p -- "$CONFIG_DIR" "$HOME"/bin "$HOME"/.themes "$HOME"/.config/gtk-3.0
HERE="$(cd "$(dirname "$0")" && pwd)"

p_install() {
	echo "Installing: $1" && sudo pacman -S --noconfirm --needed "$@"
}

y_install() {
	echo "Installing: $1" && yay -S --noconfirm --needed "$@"
}

pacman_packages=(
	base-devel
	sudo
	git
	curl
	wget
	xorg
	xorg-xinit
	xclip
	cmake
	ninja
	python-wheel
	python2-wheel
	rustup
)

yay_normal_packages=(
	rofi
	neofetch
	pcmanfm-gtk3
	jq
	xdotool
	ttf-font-awesome
	chromium
	wget
	bat
	ripgrep
	fast
	gist
	openvpn
	openssh
)

yay_git_packages=(
	alacritty-git
	bspwm-git
	sxhkd-git
	zsh-git
	zsh-completions-git
	gvim-git
	tmux-git
	picom-jonaburg-git
	polybar-git
	clipster-git
	dunst-git
	screenkey-git
	zathura-git
)

echo "Updating pacman DB"
sudo pacman -Syyu
echo "Installing pacman packages"
for pack in "${pacman_packages[@]}"; do p_install "$pack"; done
rustup default stable # for alacritty-git
sudo pacman -Rns vim --noconfirm # for gvim-git

echo "Installing: yay"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd "$OLDPWD" && rm -rf yay
echo "Updating yay DB"
yay -Syyu
echo "Installing yay packages"
for pack in "${yay_normal_packages[@]}"; do y_install "$pack"; done
for pack in "${yay_git_packages[@]}"; do y_install "$pack"; done

echo "Clearing build cache"
yay -Sc --noconfirm

echo "Cloning tmux plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-copycat "$HOME"/.tmux/plugins/tmux-copycat
git clone https://github.com/tmux-plugins/tmux-yank "$HOME"/.tmux/plugins/tmux-yank
git clone https://github.com/tmux-plugins/tmux-prefix-highlight "$HOME"/.tmux/plugins/tmux-prefix-highlight

echo "Installing: fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf && "$HOME"/.fzf/install --no-update-rc --no-completion --no-key-bindings

echo "Making symlinks"
ln -sf -- "$HERE"/alacritty "$CONFIG_DIR"
ln -sf -- "$HERE"/bspwm "$CONFIG_DIR"
ln -sf -- "$HERE"/sxhkd "$CONFIG_DIR"
ln -sf -- "$HERE"/rofi "$CONFIG_DIR"
ln -sf -- "$HERE"/polybar "$CONFIG_DIR"
ln -sf -- "$HERE"/dunst "$CONFIG_DIR"
ln -sf -- "$HERE"/clipster "$CONFIG_DIR"
ln -sf -- "$HERE"/screenkey "$CONFIG_DIR"
ln -sf -- "$HERE"/neofetch "$CONFIG_DIR"
ln -sf -- "$HERE"/zathura "$CONFIG_DIR"
ln -sf -- "$HERE"/pcmanfm "$CONFIG_DIR"
ln -sf -- "$HERE"/gtk/settings.ini "$CONFIG_DIR"/gtk-3.0/
ln -sf -- "$HERE"/picom/picom.conf "$CONFIG_DIR"
ln -sf -- "$HERE"/zsh/.zsh "$HOME"
ln -sf -- "$HERE"/zsh/.zshrc "$HOME"
ln -sf -- "$HERE"/vim/.vim "$HOME"
ln -sf -- "$HERE"/vim/.vimrc "$HOME"
ln -sf -- "$HERE"/tmux/.tmux.conf "$HOME"
ln -sf -- "$HERE"/gtk/Gruvbox-Material-Dark "$HOME"/.themes/
ln -sf -- "$HERE"/scripts "$HOME"
ln -sf -- "$HOME"/scripts/btc.sh "$HOME"/bin/btc
ln -sf -- "$HOME"/scripts/etc.sh "$HOME"/bin/etc
ln -sf -- "$HOME"/scripts/screencast.sh "$HOME"/bin/cast
ln -sf -- "$HOME"/scripts/docker_descendants.py "$HOME"/bin/docker_descendants
ln -sf -- "$HOME"/scripts/kp.sh "$HOME"/bin/kp
ln -sf -- "$HOME"/scripts/notify2.sh "$HOME"/bin/notify2
ln -sf -- "$HOME"/scripts/out.sh "$HOME"/bin/out
ln -sf -- "$HOME"/scripts/vpn.sh "$HOME"/bin/vpn
ln -sf -- "$HERE"/misc/autologin.conf /etc/systemd/system/getty@tty1.service.d/override.conf

echo "Changing default shell to zsh"
chsh -s /usr/bin/zsh

echo "Enable required systemd services"
systemctl enable getty@tty1.service
systemctl enable --user dunst.service --now
