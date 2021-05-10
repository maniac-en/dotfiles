#!/usr/bin/env bash

set -e
trap 'printf "\e[31m%s: %s\e[m\n" "status code" $?' ERR
trap _confirm_sigint SIGINT

# check to make sure user running the script is NOT root
if [[ "$EUID" -eq 0 ]]; then printf "\e[31m%s\e[m" "This script must NOT be run as root!"; exit 1; fi

CONFIG_DIR="$HOME"/.config
HERE="$(cd "$(dirname "$0")" && pwd)"
mkdir -p -- "$CONFIG_DIR"
mkdir -p -- "$HOME"/bin
mkdir -p -- "$HOME"/.themes
mkdir -p -- "$HOME"/.config/gtk-3.0
mkdir -p -- "$HOME"/.cache/vim

_confirm_sigint() {
	printf "\n"
	read -rp "SIGINT caught: Are you sure you want to stop running the installation script? [y/N]" res
	([ "$res" == "y" ] || [ "$res" == "Y" ]) && exit 1 || return
}

p_install() {
	echo "Installing: $1" && sudo pacman -S --noconfirm --needed "$@"
}

y_install() {
	echo "Installing: $1" && yay -S --noconfirm --needed "$@"
}

_revert_to_bak_file() {
	dir=$(dirname "$1")
	base=$(basename "$1")
	cp "$dir/$base.bak" "$dir/$base.new"
	cp "$dir/$base" "$dir/$base.bak"
	mv -f "$dir/$base.new" "$dir/$base"
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
	networkmanager
	python-wheel
	python2-wheel
	python-pip
	python2-pip
	python-pipx
	dbus
	dbus-python
	rustup
)

yay_normal_packages=(
	rofi
	neofetch
	pcmanfm-gtk3
	jq
	xdotool
	chromium
	firefox
	wget
	bat
	ripgrep
	fast
	gist
	openvpn
	openssh
	pavucontrol
	pulseaudio
	pulseaudio-bluetooth
	ttf-font-awesome
	ttf-fantasque-sans-mono
	noto-fonts-emoji
	spotify
	discord
	zathura
	vscodium-bin
)

yay_git_packages=(
	alacritty
	bspwm
	sxhkd
	zsh
	zsh-completions
	gvim
	tmux
	picom-jonaburg
	polybar
	clipster
	dunst
	screenkey
	sxiv
	feh
	pamixer
	maim
)

echo "Enabling autologin"
sudo mkdir -p -- /etc/systemd/system/getty@tty1.service.d
sudo ln -sf -- "$HERE"/misc/autologin.conf /etc/systemd/system/getty@tty1.service.d/override.conf
sudo systemctl enable getty@tty1.service

echo "Generating locale"
sudo ln -sf -- "$HERE"/locale/locale.conf /etc/locale.conf
sudo ln -sf -- "$HERE"/locale/locale.gen /etc/locale.gen
sudo locale-gen

echo "Updating pacman DB"
sudo pacman -Syyu --noconfirm
echo "Set tty font"
pacman -S terminus-font --noconfirm && setfont ter-122b
echo "Installing pacman packages"
for pack in "${pacman_packages[@]}"; do p_install "$pack"; done
rustup default stable # for alacritty-git
sudo pacman -Rns vim --noconfirm # for gvim-git
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import - # spotify gpg

echo "Installing: yay"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd "$OLDPWD" && rm -rf yay
echo "Updating yay DB"
yay -Syyu --noconfirm
echo "Installing yay packages"
for pack in "${yay_normal_packages[@]}"; do y_install "$pack"; done
for pack in "${yay_git_packages[@]}"; do y_install "$pack"-git; done
echo "Clearing build cache"
yay -Sc --noconfirm

echo "Cloning tmux plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-copycat "$HOME"/.tmux/plugins/tmux-copycat
git clone https://github.com/tmux-plugins/tmux-yank "$HOME"/.tmux/plugins/tmux-yank
git clone https://github.com/tmux-plugins/tmux-prefix-highlight "$HOME"/.tmux/plugins/tmux-prefix-highlight

echo "Installing: fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf && "$HOME"/.fzf/install --no-update-rc --no-completion --no-key-bindings

echo "Changing default monospace font"
if (fc-list | grep -q -F "Comic Code Medium")
then
	true
else
	_revert_to_bak_file "$HERE"/alacritty/alacritty.yml
	_revert_to_bak_file "$HERE"/sxhkd/sxhkdrc
	_revert_to_bak_file "$HERE"/rofi/config.rasi
	_revert_to_bak_file "$HERE"/polybar/config.ini
	_revert_to_bak_file "$HERE"/dunst/dunstrc
	_revert_to_bak_file "$HERE"/neofetch/config.conf
fi

echo "Symlinking dotfiles"
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
ln -sf -- "$HERE"/zsh/ "$HOME"
ln -sf -- "$HERE"/zsh/.zlogin "$HOME"
ln -sf -- "$HERE"/vim/.vim "$HOME"
ln -sf -- "$HERE"/vim/.vimrc "$HOME"
ln -sf -- "$HERE"/misc/background.png "$HOME"
ln -sf -- "$HERE"/feh/.fehbg "$HOME"
ln -sf -- "$HERE"/scripts "$HOME"
ln -sf -- "$HERE"/fontconfig "$CONFIG_DIR"
ln -sf -- "$HERE"/picom/picom.conf "$CONFIG_DIR"
ln -sf -- "$HERE"/tmux/.tmux.conf "$HOME"
ln -sf -- "$HERE"/X/.xinitrc "$HOME"/.xinitrc
ln -sf -- "$HERE"/compdefs/ "$HOME"/.zsh_functions
ln -sf -- "$HERE"/gtk/settings.ini "$CONFIG_DIR"/gtk-3.0/
ln -sf -- "$HERE"/gtk/Gruvbox-Material-Dark "$HOME"/.themes/
ln -sf -- "$HERE"/scripts/btc.sh "$HOME"/bin/btc
ln -sf -- "$HERE"/scripts/etc.sh "$HOME"/bin/etc
ln -sf -- "$HERE"/scripts/screencast.sh "$HOME"/bin/cast
ln -sf -- "$HERE"/scripts/docker_descendants.py "$HOME"/bin/docker_descendants
ln -sf -- "$HERE"/scripts/kp.sh "$HOME"/bin/kp
ln -sf -- "$HERE"/scripts/notify2.sh "$HOME"/bin/notify2
ln -sf -- "$HERE"/scripts/out.sh "$HOME"/bin/out
ln -sf -- "$HERE"/scripts/vpn.sh "$HOME"/bin/vpn
sudo ln -sf -- "$HERE"/misc/vconsole.conf /etc

echo "Changing default shell to zsh"
sudo chsh $USER -s /usr/bin/zsh
reboot
