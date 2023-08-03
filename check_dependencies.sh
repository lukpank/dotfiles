#!/bin/sh

echo '# required:'
for CMD in \
	zsh \
	git \
	cc \
	make \
	setxkbmap \
	slock \
	systemctl \
	xmodmap \
	xrandr \
	xrdb \
	xset \
	xsetroot \
	hsetroot \
	xsettingsd \
	sed \
	pkill \
	dmenu \
	dmenu_run \
	xss-lock \
	exa \
	fzf \
	; do
    which "$CMD"
done

echo -e '\n# optional:'
for CMD in \
	sx \
	picom \
	compton \
	xbacklight; do
    which "$CMD"
done
