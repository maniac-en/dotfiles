if ! hash rofi 2>/dev/null; then exit 1; fi
cat "$HOME"/.zsh/zsh-config/10-aliases.zsh | rofi -dmenu -i -markup-rows -no-show-icons -width 1400 -lines 15 -p "aliases" && exit 0
