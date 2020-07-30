#!/bin/sh

case "$1" in
    lupan-dark|lupan-dark-blue|lupan-dark-gray|lupan-light|lupan-material-dark|lupan-material-light)
	sed -i "s/^colors: [*].*/colors: *$1/" ~/.config/alacritty/alacritty.yml
	;;
    --next)
	case $(grep colors: ~/.config/alacritty/alacritty.yml) in
	    'colors: *lupan-dark')
		THEME=lupan-dark-blue
		;;
	    'colors: *lupan-dark-blue')
		THEME=lupan-dark-gray
		;;
	    'colors: *lupan-dark-gray')
		THEME=lupan-light
		;;
	    'colors: *lupan-light')
		THEME=lupan-material-dark
		;;
	    'colors: *lupan-material-dark')
		THEME=lupan-material-light
		;;
	    *)
		THEME=lupan-dark
		;;
	esac
	sed -i "s/^colors: [*].*/colors: *$THEME/" ~/.config/alacritty/alacritty.yml
	;;
esac
