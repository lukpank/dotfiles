#!/bin/sh

if [ -z "$EDITOR" ]; then
    . ~/.profile
fi

xrandr --auto
xrandr --output HDMI1 --right-of DP1
xsetroot -solid '#224242'
xrdb -merge ~/.Xresources
setxkbmap pl -option ctrl:nocaps

# lock screen on suspend/hibernate
if which xss-lock slock >/dev/null; then
    xss-lock slock &
else
    ( echo "Missing command(s):"; which xss-lock slock 2>&1 ) | xmessage -file -
fi

# run emacs daemon if not running
emacsclient --eval nil -a '' &

exec /usr/bin/bspwm
exec /usr/bin/i3
dwm-clock &
exec /usr/local/bin/dwm
exec xterm
