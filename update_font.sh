#!/usr/bin/env bash

set -e
if ! hash fzf 2>/dev/null; then exit 1; fi

# re-build font cache
fc-cache

HERE="$(cd "$(dirname "$0")" && pwd)"
possible_config_files=(
    alacritty
    clipster
    dunst
    rofi
    screenkey
)

# patch functions
_patch_alacritty() {
    true
}

_patch_clipster() {
    true
}

_patch_rofi() {
    true
}

_patch_dunst() {
    true
}

_patch_screenkey() {
    true
}

_patch_all() {
    true
}

# get user inputs, and call the subsequent patch function
main() {
    selected_conf_file=$(printf '%s\n' "${possible_config_files[@]}" | fzf \
    --header="Choose a config file to update:" --no-sort --ansi --info=hidden)
    if [[ -n "$selected_conf_file" ]]
    then
        selected_font_style=$(fc-list | cut -d ':' -f 2 | sort -u | fzf \
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
        screenkey)
            _patch_screenkey "$selected_font_style" "$selected_font_size"
            ;;
        all)
            _patch_all "$selected_font_style" "$selected_font_size"
            ;;
    esac
}

# call main
main
