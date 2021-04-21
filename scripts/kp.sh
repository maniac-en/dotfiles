#!/usr/bin/env bash
function kp() {
    local pid
    pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')
    if [ "x$pid" != "x" ]
    then
      echo "$pid" | sudo xargs kill -"${1:-9}"
      kp "$@"
    fi
}
kp "$@"
