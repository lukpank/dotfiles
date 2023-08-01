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

if [ -x  ~/.fehbg ]; then
    ~/.fehbg &
else
    hsetroot -solid '#4a4a4a'
fi

# lock screen on suspend/hibernate
if which xss-lock slock >/dev/null; then
    xss-lock slock &
else
    ( echo "Missing command(s):"; which xss-lock slock 2>&1 ) | xmessage -file -
fi

xsettingsd &

xsetroot -cursor_name left_ptr

picom -b -I 1 -O 1 -i 1 -e 1 --no-fading-openclose || compton -b --no-fading-openclose

if which dwm > /dev/null; then
    lupan-clock &
    exec dwm
fi

if which xmonad > /dev/null && test -f ~/.config/xmonad/xmonad.hs; then
    exec xmonad
fi

if which stumpwm > /dev/null && test -f ~/.stumpwm.d/init.lisp; then
   export SBCL_HOME="$(dirname $(dirname $(readlink -f $(which sbcl))))/lib/sbcl/"
   exec stumpwm
fi

if which qtile > /dev/null && test -f ~/.config/qtile/config.py; then
    exec qtile start
fi

if which spectrwm > /dev/null && test -f ~/.spectrwm.conf; then
    exec spectrwm
fi

if which lupan-wm > /dev/null; then
    xsetroot -cursor_name left_ptr
    lupan-clock &
    exec lupan-wm -s 20
fi

if which bspwm > /dev/null; then
    sxhkd &
    exec bspwm
fi

if which i3 > /dev/null; then
    exec i3
fi

exec xterm
