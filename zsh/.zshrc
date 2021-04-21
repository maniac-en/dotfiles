# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fpath+=${ZDOTDIR:-~}/.zsh_functions

# exports
export LC_ALL="en_US.utf8"
export TERM="xterm-256color"
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"
export PATH="/usr/lib/postgresql/12/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
source "$HOME/.cargo/env"

# terminal options
autoload -U colors && colors
unsetopt correct_all
unsetopt COMPLETE_ALIASES
unsetopt flowcontrol
set -o emacs
setopt NO_BEEP
setopt NO_CASE_GLOB
setopt PROMPT_SUBST
setopt interactive_comments

# keybinds
bindkey -e
[ -f "$HOME"/.zsh/keys.zsh ] && source "$HOME"/.zsh/keys.zsh
[ -f "$HOME"/.fzf/shell/key-bindings.zsh ] && source "$HOME"/.fzf/shell/key-bindings.zsh

# api keys
[ -f "$HOME"/.env.api ] && source "$HOME"/.env.api

# ugly ls colors
export LS_COLORS="$LS_COLORS:ow=31:tw=31"

# history
HISTFILE=$HOME/.zsh_history # save history
setopt SHARE_HISTORY # shared history
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS # do not store duplications
setopt HIST_FIND_NO_DUPS # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS # removes blank lines from history
SAVEHIST=100000
HISTSIZE=100000

# aliasas
[ -f "$HOME"/.zsh/aliases.zsh ] && source "$HOME"/.zsh/aliases.zsh

# prompt
function _short_dir() { sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"; }
function _git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }
PS1='$(_short_dir)%F{green}$(_git_branch)%F{red}❯ %F{white}'

# fzf setup
[ -f "$HOME"/.fzf.zsh ] && source "$HOME"/.fzf.zsh
FD_OPTIONS="--follow --hidden --exclude .git"
export FZF_CTRL_R_OPTS="--sort --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--no-mouse --height 40% --layout reverse"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd -t f -t l $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --multi --info inline --border"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="blsd" # https://github.com/junegunn/blsd

# build completion menu
autoload -Uz compinit
setopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist
autoload bashcompinit && bashcompinit # load bashcompinit for some old bash completions
zstyle :compinstall filename '/home/$USER/.zshrc'

# zsh-autosuggestions
[ -f "$HOME"/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source "$HOME"/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969,bold"

# zsh-syntax-hignlighting (should be last)
[ -f "$HOME"/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source "$HOME"/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-z
[ -f "$HOME"/.zsh/zsh-z/zsh-z.plugin.zsh ] && source "$HOME"/.zsh/zsh-z/zsh-z.plugin.zsh
ZSHZ_CASE=smart

# colored man pages in zsh
[ -f "$HOME"/.zsh/colored-man-pages.plugin.zsh ] && source "$HOME"/.zsh/colored-man-pages.plugin.zsh

# custom functions
[ -f "$HOME"/.zsh/custom_functions.zsh ] && source "$HOME"/.zsh/custom_functions.zsh

# Basic auto/tab complete
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
# disable tab-insertion on whitespace
zstyle ':completion:*' insert-tab false
# case insensitive https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
bindkey -M menuselect '^o' accept-and-infer-next-history
compinit
_comp_options+=(globdots)

# todo stuff
# if [ -f "$HOME"/.todo ]; then cat "$HOME"/.todo; fi
