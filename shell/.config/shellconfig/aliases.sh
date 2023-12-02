alias v=nvim
alias ll='ls -l'

if which exa > /dev/null; then
    alias ls='exa --icons'
    alias tree='exa --tree --icons'
fi

alias nocaps='setxkbmap pl -option ctrl:nocaps'
alias fixdp='xrandr --output DP-0 --right-of DP-2'
