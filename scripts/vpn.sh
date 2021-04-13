#!/bin/bash
set -e

_usage() {
    echo "Usage : $(basename "$0") [htb|thm|csl]"
    exit 1
}

if [ ! $# -eq 1 ]; then _usage; fi
case "$1" in
    htb|thm|csl)
        sudo openvpn "$HOME"/0x11/"$1"/man1ac.ovpn
        exit 0
        ;;
    *)
        _usage
        ;;
esac
