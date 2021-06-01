#!/usr/bin/env bash

set -e
if ! hash fzf 2>/dev/null; then exit 1; fi

# re-build font cache
fc-cache

HERE="$(cd "$(dirname "$0")" && pwd)"
possible_config_files=(
    alacritty
    all
    clipster
    dunst
    rofi
)

# patch functions
_patch_alacritty() {
    local conf_file="$HERE/dotfiles/alacritty/alacritty.yml"
    local normal_face=$(fc-list "$1" --format="%{style}\n" | sed 's#,#\n#g' | \
        sort -u | fzf --header="Choose \"Normal\" font face" --no-sort  --ansi \
        --info=hidden)
    local italic_face=$(fc-list "$1" --format="%{style}\n" | sed 's#,#\n#g' | \
        sort -u | fzf --header="Choose \"Italic\" font face" --no-sort  --ansi \
        --info=hidden)
    # font family
    sed -i "111s#.*#    family: $1#" "$conf_file"
    sed -i "133s#.*#    family: $1#" "$conf_file"
    # normal font face
    sed -i "114s#.*#    style: $normal_face#" "$conf_file"
    # italic font face
    sed -i "136s#.*#    style: $italic_face#" "$conf_file"
    # font size
    sed -i "139s#.*#  size: $2#" "$conf_file"

    # update neofetch as well
    sed -i "12s#.*#\tprintf -v term_font \"$1\"#" \
        "$HERE/dotfiles/neofetch/config.conf"
}

_patch_clipster() {
    local conf_file="$HERE/dotfiles/scripts/system/clipster.sh"
    sed -i "4s#.*#    | rofi -font \"$1 $2\" \\\\#" "$conf_file"
}

_patch_rofi() {
    local conf_file="$HERE/dotfiles/rofi/config.rasi"
    sed -i "6s#.*#\tfont: \"$1 $2\";#" "$conf_file"

    # update sxhkd command for workspace as well
    sed -i "69s#.*#    rofi -show window -i -font \"$1 14\" -width 75#" \
        "$HERE/dotfiles/sxhkd/sxhkdrc"
}

_patch_dunst() {
    local conf_file="$HERE/dotfiles/dunst/dunstrc"
    sed -i "14s#.*#    font = $1 $2#" "$conf_file"
}

_patch_all() {
    _patch_alacritty "$1" "$2"
    _patch_clipster "$1" "$2"
    _patch_rofi "$1" "$2"
    _patch_dunst "$1" "$2"
}

# get user inputs, and call the subsequent patch function
main() {
    selected_conf_file=$(printf '%s\n' "${possible_config_files[@]}" | fzf \
    --header="Choose a config file to update:" --no-sort --ansi --info=hidden)
    if [[ -n "$selected_conf_file" ]]
    then
        selected_font_style=$(fc-list : family | tr ',' '\n' | sort -u | fzf \
        --header="Choose a font style:" --no-sort --ansi --info=hidden | xargs)
        if [[ -n "$selected_font_style" ]]
        then
            selected_font_size=$(seq 10 69 | fzf \
                --header="Choose a font size[10-69]:" --no-sort --ansi \
                --info=hidden)
                if [[ -z "$selected_font_size" ]]; then exit 1; fi
            else
                exit 1
        fi
    else
        exit 1
    fi

    case "$selected_conf_file" in
        alacritty)
            _patch_alacritty "$selected_font_style" "$selected_font_size"
            ;;
        clipster)
            _patch_clipster "$selected_font_style" "$selected_font_size"
            ;;
        rofi)
            _patch_rofi "$selected_font_style" "$selected_font_size"
            ;;
        dunst)
            _patch_dunst "$selected_font_style" "$selected_font_size"
            ;;
        all)
            _patch_all "$selected_font_style" "$selected_font_size"
            ;;
    esac
}

# call main
main
