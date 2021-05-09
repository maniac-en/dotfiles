# shorten PWD as follows
	# if PWD is /sample/output  -> /s/output
	# if PWD is /.config/output -> /.c/output
function _short_dir() {
	sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"
}

# get current working branch if present in a git directory
function _git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1='%F{214}$(_short_dir)%F{green}$(_git_branch)%F{red}❯ %F{white}'
PS1='%F{214}$(_short_dir)%F{015}$(_git_branch) %F{white}'
