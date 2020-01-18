#!/bin/sh

if [ -z "$EDITOR" ]; then
    . ~/.profile
fi

xrandr --auto
xrandr --output HDMI1 --right-of DP1
xsetroot -solid '#424242'
xrdb -merge ~/.Xresources
setxkbmap pl -option ctrl:nocaps

# run emacs daemon if not running
emacsclient --eval nil -a '' &

exec /usr/bin/i3
dwm-clock &
exec /usr/local/bin/dwm
exec xterm
