# https://wiki.archlinux.org/index.php/zsh#Key_bindings
typeset -g -A key

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

function _delete-char-or-region() {
	[[ $REGION_ACTIVE -eq 1 ]] && zle kill-region || zle delete-char
}
zle -N _delete-char-or-region
bindkey -- ${terminfo[kdch1]}	_delete-char-or-region
bindkey -- ${terminfo[kich1]}	quoted-insert
bindkey -- ${terminfo[khome]}	beginning-of-line
bindkey -- ${terminfo[kend]}	end-of-line
bindkey -- ${terminfo[kich1]}	overwrite-mode
bindkey -- ${terminfo[kpp]}	beginning-of-buffer-or-history
bindkey -- ${terminfo[knp]}	end-of-buffer-or-history
bindkey -- ${terminfo[khome]}	beginning-of-line
bindkey -- ${terminfo[kend]}	end-of-line
bindkey -- ${terminfo[kbs]}	backward-delete-char
bindkey -- ${terminfo[kcub1]}	backward-char
bindkey -- ${terminfo[kcuf1]}	forward-char
bindkey -- ${terminfo[kLFT5]}  	backward-word
bindkey -- ${terminfo[kRIT5]}  	forward-word

# fix for tmux + zsh (might need)
bindkey -- "\e[1~" 		beginning-of-line
bindkey -- "\e[4~" 		end-of-line

# move up/down history based on current command
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -- ${terminfo[kcuu1]}	up-line-or-beginning-search
bindkey -- ${terminfo[kcud1]}	down-line-or-beginning-search

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Completion
zmodload zsh/complist
bindkey -M menuselect ${terminfo[kcbt]}	reverse-menu-complete	# shift-tab
bindkey -M menuselect ${terminfo[kpp]}	backward-word		# page-down
bindkey -M menuselect ${terminfo[knp]}	forward-word		# page-up
bindkey -M menuselect '\eo'		accept-and-infer-next-history	# ctrl-o
bindkey -M menuselect '/'  		accept-and-infer-next-history
bindkey -- '\ee'			end-of-list		# ctrl-e

# Misc
bindkey -- '\eq'			push-line-or-edit	# ctrl-o
bindkey -- '^[p'			copy-prev-shell-word	# alt-p
bindkey -- '^[,' 			"^[."			# bind alt-, to alt-.

# Quickly jump right after the first word (e.g. to insert switches)
function _after-first-word() {
	zle beginning-of-line
	zle forward-word
}
zle -N _after-first-word
bindkey '\C-X1' _after-first-word
