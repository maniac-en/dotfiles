autoload -Uz vcs_info

# if PWD is /config/output  -> /c/output
# if PWD is /.config/output -> /.c/output
function _short_dir() {
    sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"
}

function _is_git_dir() {
    if git rev-parse --git-dir &>/dev/null; then printf "*"; fi
}

PS1='%F{214}$(_short_dir)$(_is_git_dir) %F{white}'

# get branch if PWD is a git dir
# function _git_branch() {
#     if git rev-parse --git-dir &> /dev/null
#     then
#         printf "%%F{007}%s" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
#     fi
# }

# PS1='%F{214}$(_short_dir)$(_git_branch) %F{white}'

# # https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# zstyle ':vcs_info:git:*' formats "%F{white} (%b)"
#
# PS1='%F{214}$(_short_dir)$vcs_info_msg_0_ %F{white}'
