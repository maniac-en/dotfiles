# source
[ -f "$HOME"/.fzf.zsh ] && source "$HOME"/.fzf.zsh

# config
FD_OPTIONS="--follow --hidden --exclude .git"
export FZF_CTRL_R_OPTS="--sort --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_OPTS="--no-mouse --height 40% --layout reverse"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd -t f -t l $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --multi --info inline --border"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="blsd" # https://github.com/junegunn/blsd
