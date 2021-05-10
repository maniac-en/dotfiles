# if PWD is /config/output  -> /c/output
# if PWD is /.config/output -> /.c/output
function _short_dir() {
	sed -e "s|$HOME|~|;s|\(\.\?[^/]\)[^/]*/|\1/|g;" <<< "$PWD"
}

# check if PWD is a git dir
# check is worktree is dirty or clean using git status --porcelain (link below)
# https://stackoverflow.com/questions/19206816/what-to-add-to-git-status-porcelain-to-make-it-behave-like-git-status
# echo current branch name with red as dirty branch and white as clean branch
function _git_status() {
	if git rev-parse --git-dir > /dev/null 2>&1
	then
		local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
		if [ $(git status --porcelain 2> /dev/null | wc -l) != "0" ]
		then
			# dirty -> red
			printf "%%F{red}%s" "$branch"
		else
			# clean -> white
			printf "%%F{white}%s" "$branch"
		fi
	fi
}

PS1='%F{214}$(_short_dir)$(_git_status) %F{white}'
