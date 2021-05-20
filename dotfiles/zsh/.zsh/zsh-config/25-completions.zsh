# Initialize completion
autoload -Uz compinit
compinit -d "$ZSH_CACHE/zcompdump"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE

# Enable approximate completions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'

# It's for when you run compinstall again. It lets compinstall find where it has written out zstyle statements for you last time. This way, you can run compinstall again to update them.
zstyle :compinstall filename '/home/$USER/.zshrc'

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Use menu completion
zstyle ':completion:*' menu yes select

# Verbose completion results
zstyle ':completion:*' verbose true

# Smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'

# Group results by category
zstyle ':completion:*' group-name ''

# Don't insert a literal tab when trying to complete in an empty buffer
zstyle ':completion:*' insert-tab false

# disable tab-insertion on whitespace
zstyle ':completion:*' insert-tab false

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Don't complete hosts from /etc/hosts
zstyle -e ':completion:*' hosts 'reply=()'

# Don't complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns \
		adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
		clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
		gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
		ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
		named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
		operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
		rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
		usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
		shoutcast tcpdump '_*'
zstyle ':completion:*' single-ignored show

# case insensitive https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# press Ctrl-o to accept suggestion and proceed to next menu if possible
bindkey -M menuselect '^o' accept-and-infer-next-history

# deleting inbuilt mcd completion from mtools package
compdef -d _mcd
