# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==================================
#       ALIASES/FUNCTIONS
# ==================================

alias la='ls -A'
alias ll='ls -lAh'
alias ...='cd ../..'
alias ..='cd ..'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias please='sudo'
alias :q='exit'
alias :wq='exit'
alias clear='clear -x' # dont clear scrollback

# make dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# required for proper coloring in kitty terminal
if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh='kitten ssh'
fi

# ==================================
#         TAB COMPLETE
# ==================================

# Enable tab completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -d /etc/bash_completion.d ] && ! shopt -oq posix; then
     for f in /etc/bash_completion.d/*; do . "$f"; done
fi
bind 'set completion-ignore-case on'

# ==================================
#          PRETTY COLORS
# ==================================

alias ls='ls --color=auto'
alias grep='grep --color=auto'

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
PS1='[\[$(tput setaf $HOST_COLOR)\]\h \[$(tput sgr0; tput setaf $USER_COLOR)\]\u\[$(tput sgr0; tput setaf 14)\] \W\[$(tput sgr0)\]]\$ '

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
check_config_changes "$HOME/.config/tmux"
check_config_changes "/etc/nixos"

# ==================================
#            BASH HISTORY
# ==================================

HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth
PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
HISTIGNORE='ls:ll:cd:pwd:bg:fg:history'
shopt -s histappend

locale -a | grep en_US.utf8 > /dev/null || (echo "Missing en_US locales. Generating now..." && locale-gen en_US.UTF-8)

