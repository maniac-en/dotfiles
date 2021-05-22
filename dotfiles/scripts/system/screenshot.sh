#!/usr/bin/env bash

if ! hash maim 2>/dev/null; then exit 1; fi

API_KEY="$IMGUR_CLIENT_SECRET"
SCREENSHOT_DIR="$HOME/screenshots"
LOG_FILE="$HOME/.cache/screenshots.log"
new_img_path=""
new_img_name=""

mkdir -p "$SCREENSHOT_DIR"
img_path=$(mktemp --suffix .png -p "$SCREENSHOT_DIR")

function _save_log() {
    echo "$(date): $1" >> "$LOG_FILE"
}

function _save_offline() {
    cd "$SCREENSHOT_DIR"

    latest_image_index=$(for image_name in *.png; do echo $image_name | grep -F "screenshot"; \
    done 2>/dev/null | sort -V | tail -n1 | awk -F'.' '{print substr($0,11,length($0)-14)}';)

    [[ -z "$latest_image_index" ]] && latest_image_index=0
    new_index=$((latest_image_index+1))
    new_img_name="screenshot$new_index.png"
    new_img_path="$(dirname "$1")/$new_img_name"
    mv "$1" "$new_img_path"
    cd "$OLDPWD"
}

function _exit_now() {
    rm -f "$img_path" && exit 1
}

if [[ "$1" == "-partial" ]]
then
    if ! (maim -m 5 -s "$img_path"); then
        notify2 "Screenshot.sh" "There was an issue taking a screenshot" && _exit_now
    fi
elif [[ "$1" == "-full" ]]
then
    if ! (maim -m 5 "$img_path"); then
        notify2 "Screenshot.sh" "There was an issue taking a screenshot" && _exit_now
    fi
else
    _exit_now
fi

if [[ "$2" == "offline" ]]
then
    (_save_offline "$img_path" && _save_log "$new_img_name" \
        && notify2 "Screenshot.sh" "Offline screenshot saved:\n$new_img_name" ) || exit 1
        else

            link=$(curl -s -X POST -H "Authorization: Client-ID $API_KEY" \
                -F "image=@$img_path" https://api.imgur.com/3/upload.xml \
                | rg -o '<link>https://i\.(.*)</link>' -r 'https://$1' \
                | sed 's#\.png$##')

            ([[ -z "$link" ]] && _save_offline "$img_path" && _save_log "$new_img_name" \
                && notify2 "Screenshot.sh" "Upload failed!\nImage saved offline: $new_img_name") \
                || (_save_log "$link" && clipster -c <<< "$link" && clipster -r && rm -f "$img_path") || exit 1
fi
