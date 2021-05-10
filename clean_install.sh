#!/usr/bin/env bash

set -e
trap '_less_logfile' EXIT
trap '_confirm_sigint' SIGINT
DEBUG=0
logfile=$(date).log

# check to make sure user running the script is NOT root
if [[ "$EUID" -eq 0 ]]; then printf "\e[31m%s\e[m" "This script must NOT be run as root!"; exit 1; fi
# do not suppress if $1 == DEBUG
if [[ "$1" == "DEBUG" ]]; then DEBUG=1; fi

_confirm_sigint() {
	printf "\n"; read -rp "SIGINT caught: Are you sure you want to stop running the installation script? [y/N]" res
	{ [ "$res" == "y" ] || [ "$res" == "Y" ]; } && exit 1 || return
}

_less_logfile() {
	less -Nr "$logfile"
}

_echo() {
	printf "\e[32m%s\e[m\n" "$@"
}

_exec() {
	if [[ "$DEBUG" -eq 1 ]]
	then
		"$@" 2>&1 | tee -a "$logfile"
	else
		"$@" 1>> "$logfile" 2>> "$logfile"
	fi
}

_install_p() {
	printf "\t"; _echo "Installing $1" && _exec sudo pacman -S --noconfirm --needed "$@"
}

_install_y() {
	printf "\t"; _echo "Installing $1" && _exec yay -S --noconfirm --needed "$@"
}

_revert_to_bak_file() {
	dir=$(dirname "$1")
	base=$(basename "$1")
	_exec cp "$dir/$base.bak" "$dir/$base.new"
	_exec cp "$dir/$base" "$dir/$base.bak"
	_exec mv -f "$dir/$base.new" "$dir/$base"
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
	dmidecode
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
	ttf-font-awesome
	ttf-fantasque-sans-mono
	noto-fonts-emoji
	spotify
	discord
	zathura
	vscodium-bin
	pod2man # dunst-git dependency
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
	fd
	maim
	jumpapp
	redshift
)

_echo "Script init"
CONFIG_DIR="$HOME"/.config
HERE="$(cd "$(dirname "$0")" && pwd)"
_exec mkdir -p -- "$CONFIG_DIR"
_exec mkdir -p -- "$HOME"/bin
_exec mkdir -p -- "$HOME"/.themes
_exec mkdir -p -- "$HOME"/.config/gtk-3.0
_exec mkdir -p -- "$HOME"/.cache/vim
_exec mkdir -p -- "$HOME"/.cargo

_echo "Updating pacman DB"
_exec sudo pacman -Syyu --noconfirm

_echo "Set tty font"
_exec sudo pacman -S terminus-font --noconfirm
_exec setfont ter-122b

_echo "Generating locale"
_exec sudo ln -sf -- "$HERE"/locale/locale.conf /etc/locale.conf
_exec sudo ln -sf -- "$HERE"/locale/locale.gen /etc/locale.gen
_exec sudo locale-gen

_echo "Installing pacman packages"
for pack in "${pacman_packages[@]}"; do _install_p "$pack"; done

_echo "Post pacman commands"
_exec rustup default stable # for alacritty-git
_exec sudo pacman -Rns vim --noconfirm # for gvim-git
_exec curl -sSO https://download.spotify.com/debian/pubkey_0D811D58.gpg
_exec gpg --import pubkey_0D811D58.gpg
_exec rm pubkey_0D811D58.gpg

_echo "Installing: yay"
_exec git clone https://aur.archlinux.org/yay.git
_exec cd yay
_exec makepkg -si --noconfirm
_exec cd "$OLDPWD"
_exec rm -rf yay

_echo "Updating yay DB"
_exec yay -Syyu --noconfirm

_echo "Installing yay packages"
for pack in "${yay_normal_packages[@]}"; do _install_y "$pack"; done
for pack in "${yay_git_packages[@]}"; do _install_y "$pack"-git; done

_echo "Clearing build cache"
_exec yay -Sc --noconfirm

_echo "Cloning tmux plugins"
_exec git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
_exec git clone https://github.com/tmux-plugins/tmux-copycat "$HOME"/.tmux/plugins/tmux-copycat
_exec git clone https://github.com/tmux-plugins/tmux-yank "$HOME"/.tmux/plugins/tmux-yank
_exec git clone https://github.com/tmux-plugins/tmux-prefix-highlight "$HOME"/.tmux/plugins/tmux-prefix-highlight

_echo "Installing fzf"
_exec git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf
_exec "$HOME"/.fzf/install --no-update-rc --no-completion --no-key-bindings

_echo "Enabling autologin"
if [[ "$USER" != "maniac" ]]; then
	_exec rg 'maniac' -r "$USER" "$HERE/misc/autologin.conf" > tmp
	_exec mv -f tmp "$HERE/misc/autologin.conf"
fi
_exec sudo mkdir -p -- /etc/systemd/system/getty@tty1.service.d
_exec sudo ln -sf -- "$HERE"/misc/autologin.conf /etc/systemd/system/getty@tty1.service.d/override.conf
_exec sudo systemctl enable getty@tty1.service

_echo "Changing default monospace font"
if (fc-list | grep -q -F "Comic Code Medium")
then
	true
else
	_exec _revert_to_bak_file "$HERE"/alacritty/alacritty.yml
	_exec _revert_to_bak_file "$HERE"/sxhkd/sxhkdrc
	_exec _revert_to_bak_file "$HERE"/rofi/config.rasi
	_exec _revert_to_bak_file "$HERE"/polybar/config.ini
	_exec _revert_to_bak_file "$HERE"/dunst/dunstrc
	_exec _revert_to_bak_file "$HERE"/neofetch/config.conf
fi

_echo "Symlinking dotfiles"
_exec ln -sf -- "$HERE/alacritty" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/bspwm" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/sxhkd" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/rofi" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/polybar" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/dunst" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/clipster" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/screenkey" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/neofetch" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/zathura" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/pcmanfm" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/zsh/.zsh" "$HOME"
_exec ln -sf -- "$HERE/zsh/.zshrc" "$HOME"
_exec ln -sf -- "$HERE/zsh/.zlogin" "$HOME"
_exec ln -sf -- "$HERE/vim/.vim" "$HOME"
_exec ln -sf -- "$HERE/vim/.vimrc" "$HOME"
_exec ln -sf -- "$HERE/misc/background.png" "$HOME"
_exec ln -sf -- "$HERE/feh/.fehbg" "$HOME"
_exec ln -sf -- "$HERE/scripts" "$HOME"
_exec ln -sf -- "$HERE/fontconfig" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/picom/picom.conf" "$CONFIG_DIR"
_exec ln -sf -- "$HERE/tmux/.tmux.conf" "$HOME"
_exec ln -sf -- "$HERE/X/.xinitrc" "$HOME"
_exec ln -sf -- "$HERE/compdefs/" "$HOME/.zsh_functions"
_exec ln -sf -- "$HERE/gtk/settings.ini" "$CONFIG_DIR/gtk-3.0/"
_exec ln -sf -- "$HERE/gtk/Gruvbox-Material-Dark" "$HOME/.themes/"
_exec ln -sf -- "$HERE/scripts/btc.sh" "$HOME/bin/btc"
_exec ln -sf -- "$HERE/scripts/etc.sh" "$HOME/bin/etc"
_exec ln -sf -- "$HERE/scripts/screencast.sh" "$HOME/bin/cast"
_exec ln -sf -- "$HERE/scripts/docker_descendants.py" "$HOME/bin/docker_descendants"
_exec ln -sf -- "$HERE/scripts/kp.sh" "$HOME/bin/kp"
_exec ln -sf -- "$HERE/scripts/notify2.sh" "$HOME/bin/notify2"
_exec ln -sf -- "$HERE/scripts/out.sh" "$HOME/bin/out"
_exec ln -sf -- "$HERE/scripts/vpn.sh" "$HOME/bin/vpn"
_exec sudo ln -sf -- "$HERE/misc/blsd" "/usr/bin"
_exec sudo ln -sf -- "$HERE/misc/vconsole.conf" /etc

_echo "Changing default shell to zsh and rebooting"
_exec sudo chsh "$USER" -s /usr/bin/zsh
reboot
