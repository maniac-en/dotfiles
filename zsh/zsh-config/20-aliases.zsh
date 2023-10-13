#git
alias ga='git add'
alias gar='git add -v --all .'
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

#misc
alias camera='mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0'
alias nmap='sudo nmap'
alias up='sudo python -m http.server'
alias rscan='docker run -it --rm --name rustscan rustscan/rustscan:1.10.0'

#general
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias c='batcat'
alias out='shutdown now'
alias colorpicker='colorpicker --short --one-shot --preview | head -c -1 | copy'
alias copy-img='xclip -selection clipboard -t image/png'
alias copy='xclip -selection clipboard'
alias cp='cp -v'
alias du='du -sh'
alias fd='fd -HI'
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
alias p2='python2'
alias p='python'
alias remove='sudo apt remove --purge -y'
alias rg="rg --hidden --glob '!.git'"
alias s='sudo'
alias sc='source $HOME/.zshrc'
alias su='s su'
alias v='vim'
alias vc='$EDITOR $HOME/.vim/vimrc'
alias x='chmod a+x'
alias zd='$EDITOR $HOME/.zsh/zsh-config'
alias zsh_reset='rm -f ~/.zcompdump; compinit'
alias clip='xclip -sel clip'

#no idea why I made them
alias clrdockerps='docker rm $(docker ps -a -f status=exited -f status=created -q) 2>/dev/null'
alias sl="echo -e \"\nIt's ls you DUMB-ASS\n\""

# Hack(maniac): I keep changing zsh aliases file name so I wrote this workaround
export _MANIAC_ALIASES_FILE_PATH="$0:A"
alias ali="$EDITOR $_MANIAC_ALIASES_FILE_PATH && sc"