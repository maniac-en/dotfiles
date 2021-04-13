#!/usr/bin/env bash

# API_KEY="$IMGUR_CLIENT_SECRET"

function _save_log() {
	echo "$(date): $1 : $2" >> "$HOME"/.cache/imgur_links.log
}

function _take_screenshot() {
	img=$(mktemp --suffix .png -p "$HOME"/screenshots/)
	if [[ "$1" == "-partial" ]]
	then
		maim -m 5 -s "$img"
		[[ "$?" -ne 0 ]] && rm -f "$img" && exit 1
	elif [[ "$1" == "-full" ]]
	then
		maim -m 5 "$img" || exit 1
	else
		rm "$img"
		exit 1
	fi
	link=$(curl -s -X POST -H "Authorization: Client-ID $API_KEY" -F "image=@$img" https://api.imgur.com/3/upload.xml | grep -oE '<link>([^<]+)</link>' | sed 's#</\?link>##g')
	[ -z "$link" ] && \
		notify2 "Partical-screen" "Upload failed!\nImage name: $(basename $img)" &&  _save_log "$(basename $img)" "No LINK" && exit 1 \
		|| (_save_log "$(basename $img)" "$link" && rm -f "$img")
	(echo -n "$link" | xclip -selection clipboard) || exit 1
}

_take_screenshot "$1"
