#git
alias ga='git add -v'
alias gar='git add -v --all'
alias gc='git commit -S -vv'
alias gca='git commit -S --amend --date=now'
alias gco='git checkout'
alias gcr='git commit -S --amend --date=now --reuse-message=HEAD'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias gll='git listlog'
alias glq='git quicklog'
alias glv='{ git headlog &>/dev/null || : } && vim -c ":GV" -c "norm ,2,d"'
alias gp='git push'
alias gpu='git pull'
alias gr='git remote'
alias gru='git remote update --prune'
alias gs='{ git headlog 2>/dev/null || : } && git status -sb'
alias gv='{ git headlog &>/dev/null || : } && vim -c +G -c "norm tk,d"'
alias gw='git worktree'

#general
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias c='batcat'
alias clip='xclip -sel clip'
alias copy-img='xclip -selection clipboard -t image/png'
alias copy='xclip -selection clipboard'
alias cp='cp -v'
alias du='du -sh'
alias fd='fdfind -HI'
alias gdb='gdb -q'
alias install='sudo apt install -y'
alias ip='ip -c -br a'
alias l='ls'
alias la='ls -A'
alias less='less -Nr'
alias ll='ls -lh'
alias lla='ls -lhA'
alias ls='ls --group-directories-first --color=always'
alias mv='mv -i'
alias open='xdg-open'
alias out='shutdown now'
alias remove='sudo apt remove --purge -y'
alias rg="rg --hidden --glob '!.git'"
alias s='sudo'
alias shutdown='sudo shutdown'
alias su='sudo su'
alias v='vim'
alias vc='$EDITOR $HOME/.config/nvim'
alias x='chmod a+x'
alias zc="$EDITOR $HOME/.zsh/zsh-config && source $HOME/.zshrc"
alias zsh_reset='rm -f ~/.zcompdump; compinit'

#no idea why I made them
alias clrdockerps='docker rm $(docker ps -a -f status=exited -f status=created -q) 2>/dev/null'
alias sl="echo -e \"\nIt's ls you DUMB-ASS\n\""

# Hack(maniac): I keep changing zsh aliases file name so I wrote this workaround
export _MANIAC_ALIASES_FILE_PATH="$0:A"
alias ali="$EDITOR $_MANIAC_ALIASES_FILE_PATH && source $HOME/.zshrc"
