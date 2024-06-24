#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\e[34m\u@\h\e[0m \e[32m\W\e[0m \$ '

function before_command() { echo -ne '\e[2 q'; }
trap before_command DEBUG
