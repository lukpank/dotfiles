#!/bin/sh

echo '# bspwm:'
for CMD in \
    alacritty \
	bspc \
	bspwm \
	dmenu \
	dmenu_run \
	emacsclient \
	pkill \
	polybar \
	polybar-msg \
	sed \
	setxkbmap \
	slock \
	sxhkd \
	systemctl \
	xargs \
	xdo \
	xmodmap \
	xrandr \
	xrdb \
	xsetroot \
	xsettingsd \
	xtitle \
	xss-lock; do
    which "$CMD"
done

echo '\n# bspwm (optional):'
for CMD in \
    firefox \
	mpc \
	mpd \
	pamixer \
	sx \
	thunderbird \
	xbacklight; do
    which "$CMD"
done

echo '\n# shell:'
for CMD in emacsclient zsh; do
    which "$CMD"
done
