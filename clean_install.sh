#!/usr/bin/env bash

set -e
trap '_less_logfile' ERR
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

yay_packages=(
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
	alacritty-git
	bspwm
	sxhkd
	zsh-git
	zsh-completions
	gvim-git
	tmux-git
	picom-jonaburg-git
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
	colorpicker
)

_echo "Script init"
CONFIG_DIR="$HOME"/.config
HERE="$(cd "$(dirname "$0")" && pwd)"
DOT_DIR="$HERE/dotfiles"
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
_exec sudo ln -sf -- "$DOT_DIR"/locale/locale.conf /etc/locale.conf
_exec sudo ln -sf -- "$DOT_DIR"/locale/locale.gen /etc/locale.gen
_exec sudo locale-gen

_echo "Installing pacman packages"
for pack in "${pacman_packages[@]}"; do _install_p "$pack"; done

_echo "Post pacman commands"
_exec rustup default stable # for alacritty-git
_exec sudo pacman -Rns vim --noconfirm # for gvim-git
_exec curl -sSO https://download.spotify.com/debian/pubkey_0D811D58.gpg
_exec gpg --import pubkey_0D811D58.gpg
_exec rm pubkey_0D811D58.gpg
_exec sudo systemctl enable NetworkManager.service --now

_echo "Installing: yay"
_exec git clone https://aur.archlinux.org/yay.git
_exec cd yay
_exec makepkg -si --noconfirm
_exec cd "$OLDPWD"
_exec rm -rf yay

_echo "Updating yay DB"
_exec yay -Syyu --noconfirm

_echo "Installing yay packages"
for pack in "${yay_packages[@]}"; do _install_y "$pack"; done

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
_exec sudo mkdir -p -- /etc/systemd/system/getty@tty1.service.d
_exec sudo cp -v "$DOT_DIR/autologin.conf" /etc/systemd/system/getty@tty1.service.d/override.conf
_exec sudo sed -i -e "s/maniac/$USER/" /etc/systemd/system/getty@tty1.service.d/override.conf
_exec sudo systemctl enable getty@tty1.service

_echo "Symlinking dotfiles"
_exec ln -sf -- "$DOT_DIR/alacritty" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/bspwm" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/sxhkd" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/rofi" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/polybar" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/dunst" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/clipster" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/screenkey" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/neofetch" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/zathura" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/pcmanfm" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/zsh/.zsh" "$HOME"
_exec ln -sf -- "$DOT_DIR/zsh/.zshrc" "$HOME"
_exec ln -sf -- "$DOT_DIR/zsh/.zlogin" "$HOME"
_exec ln -sf -- "$DOT_DIR/vim/.vim" "$HOME"
_exec ln -sf -- "$DOT_DIR/vim/.vimrc" "$HOME"
_exec ln -sf -- "$DOT_DIR/background.png" "$HOME"
_exec ln -sf -- "$DOT_DIR/feh/.fehbg" "$HOME"
_exec ln -sf -- "$DOT_DIR/scripts" "$HOME"
_exec ln -sf -- "$DOT_DIR/fontconfig" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/picom/picom.conf" "$CONFIG_DIR"
_exec ln -sf -- "$DOT_DIR/tmux/.tmux.conf" "$HOME"
_exec ln -sf -- "$DOT_DIR/X/.xinitrc" "$HOME"
_exec ln -sf -- "$DOT_DIR/compdefs/" "$HOME/.zsh_functions"
_exec ln -sf -- "$DOT_DIR/gtk/settings.ini" "$CONFIG_DIR/gtk-3.0/"
_exec ln -sf -- "$DOT_DIR/gtk/Gruvbox-Material-Dark" "$HOME/.themes/"
_exec ln -sf -- "$DOT_DIR/scripts/btc.sh" "$HOME/bin/btc"
_exec ln -sf -- "$DOT_DIR/scripts/etc.sh" "$HOME/bin/etc"
_exec ln -sf -- "$DOT_DIR/scripts/screencast.sh" "$HOME/bin/cast"
_exec ln -sf -- "$DOT_DIR/scripts/docker_descendants.py" "$HOME/bin/docker_descendants"
_exec ln -sf -- "$DOT_DIR/scripts/kp.sh" "$HOME/bin/kp"
_exec ln -sf -- "$DOT_DIR/scripts/notify2.sh" "$HOME/bin/notify2"
_exec ln -sf -- "$DOT_DIR/scripts/out.sh" "$HOME/bin/out"
_exec ln -sf -- "$DOT_DIR/scripts/vpn.sh" "$HOME/bin/vpn"
_exec sudo ln -sf -- "$DOT_DIR/blsd" "/usr/bin"
_exec sudo ln -sf -- "$DOT_DIR/vconsole.conf" /etc

_echo "Changing default shell to zsh and rebooting"
_exec sudo chsh "$USER" -s /usr/bin/zsh
reboot
