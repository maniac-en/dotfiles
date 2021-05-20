# Use emacs mode. Vim is nice but not in a shell.
bindkey -e
set -o emacs

# Create cache folder for compdump, etc.
ZSH_CACHE="/tmp/.zsh-dump"
mkdir -p $ZSH_CACHE
chmod 700 $ZSH_CACHE

# Add the location of zsh-completions to fpath, since it's
# not always included there by default.
typeset -U fpath
[[ -d /usr/share/zsh/site-functions ]] && fpath+=(/usr/share/zsh/site-functions)
[[ -d "$HOME"/.zsh/zsh-completions/src ]] && fpath+=("$HOME"/.zsh/zsh-completions/src)
[[ -d "$HOME"/.zsh_functions ]] && fpath+=("$HOME"/.zsh_functions)

# colors
autoload -U colors && colors
export LS_COLORS="$LS_COLORS:ow=31:tw=31"

# api keys
[ -f "$HOME"/.env.api ] && source "$HOME"/.env.api

# Don't check for mails
MAILCHECK=0
