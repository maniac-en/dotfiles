# auto start X-session
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx
