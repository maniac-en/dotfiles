#!/bin/bash
set -e

_usage() {
    echo "Usage : $(basename "$0") [htb|thm]"
    exit 1
}

if [ ! $# -eq 1 ]; then _usage; fi
case "$1" in
    htb|thm)
        sudo openvpn "$HOME"/0x11/vpn/"$1".ovpn
        exit 0
        ;;
    *)
        _usage
        ;;
esac
