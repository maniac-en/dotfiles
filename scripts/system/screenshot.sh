#!/usr/bin/env bash

if ! hash maim 2>/dev/null; then exit 1; fi
API_KEY="$IMGUR_CLIENT_SECRET"

function _save_log() {
	echo "$(date): $1 : $2" >> "$HOME"/.cache/imgur_links.log
}

function _take_screenshot() {
	img_path=$(mktemp --suffix .png -p "$HOME"/screenshots/)
	if [[ "$1" == "-partial" ]]
	then
		maim -m 5 -s "$img_path"
		[[ "$?" -ne 0 ]] && rm -f "$img_path" && exit 1
	elif [[ "$1" == "-full" ]]
	then
		maim -m 5 "$img_path" || exit 1
	else
		rm "$img_path"
		exit 1
	fi
	if [[ "$2" == "offline" ]]
	then
		new_img_path=$(dirname $img_path)/$(date +"%d-%m-%Y_%R").png
		mv "$img_path" "$new_img_path"
		notify2 "Screenshot.sh" "Offline screenshot saved\n$new_img_path"
		_save_log "$new_img_path" "OFFLINE" || exit 1
	else
		link=$(curl -s -X POST -H "Authorization: Client-ID $API_KEY" -F "image=@$img_path" https://api.imgur.com/3/upload.xml | grep -oE '<link>([^<]+)</link>' | sed 's#</\?link>##g')
		[ -z "$link" ] && \
			notify2 "Screenshot.sh" "Upload failed!\nImage name: $(basename $img_path)" &&  _save_log "$(basename $img_path)" "No LINK" && exit 1 \
			|| (_save_log "$(basename $img_path)" "$link" && rm -f "$img_path")
					(echo -n "$link" | xclip -selection clipboard) || exit 1
	fi
}

_take_screenshot "$@"
