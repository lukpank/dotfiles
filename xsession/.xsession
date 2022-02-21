#!/bin/sh

if [ -z "$EDITOR" ]; then
    . ~/.profile
fi

xset b off
xrandr --auto
xrandr --output HDMI1 --right-of DP1
xrdb -merge ~/.Xresources
setxkbmap pl -option ctrl:nocaps
xmodmap ~/.xmodmaprc

# lock screen on suspend/hibernate
if which xss-lock slock >/dev/null; then
    xss-lock slock &
else
    ( echo "Missing command(s):"; which xss-lock slock 2>&1 ) | xmessage -file -
fi

# run emacs daemon if not running
emacsclient --eval nil -a '' &

xsettingsd &

if which spectrwm > /dev/null; then
    xsetroot -solid '#4a4a4a'
    exec spectrwm
fi

if which lupan-wm > /dev/null; then
    xsetroot -solid '#4a4a4a' -cursor_name left_ptr
    lupan-clock &
    exec lupan-wm -s 20
fi

xsetroot -solid '#94a3b8' -cursor_name left_ptr

if which qtile > /dev/null; then
    exec qtile start
fi

if which bspwm > /dev/null; then
    sxhkd &
    exec bspwm
fi

if which i3 > /dev/null; then
    exec i3
fi

if which dwm > /dev/null; then
    lupan-clock &
    exec dwm
fi

exec xterm
