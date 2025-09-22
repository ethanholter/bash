# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# colorful commands
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lAh'
alias grep='grep --color=auto'
alias ...='cd ../..'
alias ..='cd ..'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias please='sudo'
alias :q='exit'
alias :wq='exit'

# for ssh
export TERM=xterm-256color

# Enable tab completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -d /etc/bash_completion.d ] && ! shopt -oq posix; then
     for f in /etc/bash_completion.d/*; do . $f; done
fi
bind 'set completion-ignore-case on'

# Colorful man pages cuz why not
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal

# prompt
exitstatus() {
    if [[ $? == 0 ]]; then
	echo "$(tput setaf 2)o$(tput sgr0)"
    else
	echo "$(tput setaf 1)x$(tput sgr0)"
    fi
}

HOST_COLOR=13

if [[ -n "$SSH_CLIENT" ]]; then
    HOST_COLOR=10
fi

PS1='$(exitstatus) [$(tput setaf $HOST_COLOR)\h $(tput sgr0; tput setaf 12 bold)\u$(tput sgr0; tput setaf 14) \W$(tput sgr0)]\$ '

# make dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Better history
export HISTSIZE=10000
export HISTFILESIZE=20000
unset HISTCONTROL
shopt -s histappend

if command -v neofetch; then
    neofetch
fi
