alias v=nvim
alias ll='ls -l'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias tn='tmux new -s'

if which exa > /dev/null; then
    alias ls='exa --icons'
    alias tree='exa --tree --icons'
fi

alias nocaps='setxkbmap pl -option ctrl:nocaps'
alias fixdp='xrandr --output DP-0 --right-of DP-2'
