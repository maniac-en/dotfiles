HISTFILE=$HOME/.zsh_history # history file location
setopt SHARE_HISTORY # enable shared history among open terminals
setopt APPEND_HISTORY # append to history
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS # do not store duplicates
setopt HIST_REDUCE_BLANKS # removes blank lines from history
SAVEHIST=100000
HISTSIZE=100000
