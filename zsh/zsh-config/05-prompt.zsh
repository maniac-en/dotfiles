# if PWD is /config/output  -> /c/output
# if PWD is /.config/output -> /.c/output
function _short_dir() {
    sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"
}

function _is_git_dir() {
    if git rev-parse --git-dir &>/dev/null; then printf "*"; fi
}

function _git_branch() {
    if git rev-parse --git-dir &> /dev/null
    then
        printf "%%F{007}%s" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
    fi
}

PS1='%F{214}$(_short_dir)$(_git_branch) %F{white}'
