#!/bin/sh

case "$1" in
    dark|dark-blue|light)
	sed -i "s/^colors: [*].*/colors: *$1/" ~/.config/alacritty/alacritty.yml
	;;
    next)
	case $(grep colors: ~/.config/alacritty/alacritty.yml) in
	    'colors: *dark')
		THEME=dark-blue
		;;
	    'colors: *dark-blue')
		THEME=light
		;;
	    *)
		THEME=dark
		;;
	esac
	sed -i "s/^colors: [*].*/colors: *$THEME/" ~/.config/alacritty/alacritty.yml
	;;
esac
