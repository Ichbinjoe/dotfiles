
# Support 256 colors
export TERM="xterm-256color" 
export ZSH="$HOME/.oh-my-zsh"
# ~/.oh-my-zsh/custom/themes/custom.zsh-theme
ZSH_THEME="custom"

# hyphen insensitive 
HYPHEN_INSENSITIVE="true"

# update every 2 weeks
export UPDATE_ZSH_DAYS=13

# command correction
ENABLE_CORRECTION="true"

# completion waiting dots
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(copydir copyfile docker extract gitfast golang gradlei npm pip tmux vi-mode)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export GOPATH=/home/joe/workspace/go

alias pdf='evince'

alias vim='nvim'
alias vi='nvim'

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
	tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

# vim: set ft=zsh: 
