autoload -Uz vcs_info

# if PWD is /config/output  -> /c/output
# if PWD is /.config/output -> /.c/output
function _short_dir() {
    sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"
}

# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats "%F{white} (%b)"

PS1='%F{214}$(_short_dir)$vcs_info_msg_0_ %F{white}'
