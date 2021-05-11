# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# exports
export LC_ALL="en_US.utf8"
export TERM="xterm-256color"
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"
export PATH="/usr/lib/postgresql/12/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# source required zsh scripts
[[ -d "$HOME"/.zsh/zsh-config ]] &&
	for zsh_files in "$HOME"/.zsh/zsh-config/*.zsh
	do
		source "$zsh_files"
	done
