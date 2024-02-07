#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

which nu >/dev/null && exec nu

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
