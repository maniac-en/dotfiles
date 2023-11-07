# source
[ -f "$HOME"/.fzf.zsh ] && source "$HOME"/.fzf.zsh

# config
export FZF_DEFAULT_OPTS="--no-mouse --info=inline --border"
local FD_OPTIONS="--type f --follow --hidden --exclude .git"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fdfind -t f -t l $FD_OPTIONS"

export FZF_CTRL_T_OPTS="
--preview 'batcat -n --color=always {}'
--height 100% --select-1 --exit-0 --multi
--bind 'ctrl-/:change-preview-window(hidden|)'"
export FZF_CTRL_T_COMMAND="fdfind $FD_OPTIONS"

export FZF_CTRL_R_OPTS="
--sort --height 50% --preview 'echo {}'
--preview-window 100:hidden:wrap --bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -e {} | cut -d \" \" -f4- | xclip -sel clip)+abort'"

export FZF_ALT_C_COMMAND="blsd" # https://github.com/junegunn/blsd
