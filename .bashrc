# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==================================
#       ALIASES/FUNCTIONS
# ==================================

# colorful commands
alias la='ls -A'
alias ll='ls -lAh'
alias ...='cd ../..'
alias ..='cd ..'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias please='sudo'
alias :q='exit'
alias :wq='exit'
alias nixconf='sudoedit /etc/nixos/configuration.nix'
alias nixbuild='sudo nixos-rebuild switch'
alias nixtest='sudo nixos-rebuild test --fast'
alias nix='nix --extra-experimental-features nix-command --extra-experimental-features flakes'
alias 'nixld-search'='nix run github:nix-community/nix-index-database --'
alias clear='clear -x' # dont clear scrollback
alias fzopn='$EDITOR $(fzf)'

# make dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# required for proper coloring in kitty terminal
if [ $TERM == "xterm-kitty" ]; then
    alias ssh='kitten ssh'
fi

# ==================================
#           ENV VARS
# ==================================

if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim   
else
    export EDITOR=vim
fi

# ==================================
#         TAB COMPLETE
# ==================================

# Enable tab completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -d /etc/bash_completion.d ] && ! shopt -oq posix; then
     for f in /etc/bash_completion.d/*; do . $f; done
fi
bind 'set completion-ignore-case on'


# ==================================
#          PRETTY COLORS
# ==================================

alias ls='ls --color=auto'
alias grep='grep --color=auto'

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

# ==================================
#             PROMPT
# ==================================

USER_COLOR=12
if [[ "$USER" == "root" ]]; then 
    USER_COLOR=9
fi

HOST_COLOR=13
if [[ -n "$SSH_CLIENT" ]]; then
    HOST_COLOR=10
fi
# note to future me: all non-printing characters (escape codes) must be wrapped with \[ and \] to prevent weird behaviors
PS1='[\[$(tput setaf $HOST_COLOR)\]\h \[$(tput sgr0; tput setaf $USER_COLOR bold)\]\u\[$(tput sgr0; tput setaf 14)\] \W\[$(tput sgr0)\]]\$ '

# ==================================
#      CONFIG CHANGED WARNING
# ==================================

check_config_changes() {
    if [[ -d $1 && -n "$(git -C $1 status -s 2>&1)" ]]; then
	echo "Uncommited changes at $1"
    fi
}

check_config_changes "$HOME/.config/nvim"
check_config_changes "$HOME/.config/vim"
check_config_changes "$HOME/.config/bash"
check_config_changes "/etc/nixos"

# ==================================
#            BASH HISTORY
# ==================================

HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth
PROMPT_COMMAND="history -a; history -n"
HISTIGNORE='ls:ll:cd:pwd:bg:fg:history'
shopt -s histappend
