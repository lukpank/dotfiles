#!/bin/sh

. ~/.profile

xrandr --auto
xrandr --output HDMI-1 --right-of DP-1
xsetroot -solid '#424242'
xrdb -merge ~/.Xresources
xmodmap ~/.xmodmaprc

xsetroot -cursor_name left_ptr
export EDITOR=emacsclient
export VISUAL=emacsclient
export MY_USE_EXWM=t
exec emacs

dwm-clock &
exec /usr/local/bin/dwm
exec /usr/bin/i3
exec xterm
