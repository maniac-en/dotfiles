#git
alias ga='git add -p'
alias gar='git add --all .'
alias gb='git branch'
alias gc='git commit -S -vv'
alias gca='git commit -S --amend'
alias gch='git checkout'
alias gcr='git commit -S --amend --reuse-message=HEAD'
alias gd='git diff'
alias gl='git verboselog'
alias gll='git log'
alias gp='git push'
alias gs='{ git headlog 2>/dev/null || : } && git status -sb'

#misc
alias camera='mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0'
alias dnd!='dunstctl set-paused false'
alias dnd='dunstctl set-paused true'
alias nmap='sudo nmap'
alias r32='tr -dc a-zA-Z0-9 < /dev/urandom | head -c 32 | copy'
alias sxiv='sxiv -r'
alias up='sudo python -m http.server'

#general
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias ac='$EDITOR $HOME/.config/alacritty/alacritty.yml'
alias bsp='$EDITOR $HOME/.config/bspwm/bspwmrc'
alias c='bat'
alias colorpicker='colorpicker --short --one-shot --preview | head -c -1 | copy'
alias copy-img='xclip -selection clipboard -t image/png'
alias copy='xclip -selection clipboard'
alias cp='cp -v'
alias du='du -sh'
alias fd='fd -HI'
alias gdb='gdb -q'
alias get_class='xprop | grep "WM_CLASS"'
alias getcd="pwd | tr -d '\n' | copy"
alias info='printf "\n" ; neofetch --config $HOME/.config/neofetch/config.conf | sed "16d"'
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
alias pacman='s pacman'
alias rg="rg --hidden --glob '!.git'"
alias s='sudo'
alias sc='source $HOME/.zshrc'
alias su='s su'
alias sv='sudo vim'
alias sx='$EDITOR $HOME/.config/sxhkd/sxhkdrc'
alias v='vim'
alias vc='$EDITOR $HOME/.vimrc'
alias vi='vim'
alias x='chmod a+x'
alias zc='$EDITOR $HOME/.zshrc'
alias zd='$EDITOR $HOME/.zsh/zsh-config'

#no idea why I made them
alias clrdockerps='docker rm $(docker ps -a -f status=exited -f status=created -q) 2>/dev/null'
alias sl="echo -e \"\nIt's ls you DUMB-ASS\n\""

# Hack(maniac): I keep changing zsh aliases file name so I wrote this workaround
export _MANIAC_ALIASES_FILE_PATH="$0:A"
alias ali="$EDITOR $_MANIAC_ALIASES_FILE_PATH && sc"
