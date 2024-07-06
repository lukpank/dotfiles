#!/bin/sh

REQUIRED="$1"

check_dependency() {
	local CMD="$1"
	shift
	for REQ in "$@"; do
		if [ "$REQ" = "$REQUIRED" ]; then
			which "$CMD"
			break
		fi
	done
}

echo '# required:'

check_dependency zsh dwm hypr
check_dependency git dwm hypr
check_dependency cc dwm
check_dependency make dwm
check_dependency setxkbmap dwm
check_dependency slock dwm
check_dependency systemctl dwm hypr
check_dependency xmodmap dwm
check_dependency xrandr dwm
check_dependency xrdb dwm
check_dependency xset dwm
check_dependency xsetroot dwm
check_dependency hsetroot dwm
check_dependency xsettingsd dwm
check_dependency sed dwm hypr
check_dependency pkill dwm
check_dependency dmenu dwm
check_dependency dmenu_run dwm
check_dependency xss-lock dwm
check_dependency exa dwm hypr
check_dependency fzf dwm hypr
check_dependency Hyprland hypr
check_dependency hyprctl hypr
check_dependency alacritty hypr
check_dependency swaylock hypr
check_dependency waybar hypr
check_dependency wofi hypr

echo -e '\n# optional:'

check_dependency sx dwm
check_dependency picom dwm
check_dependency compton dwm
check_dependency xbacklight dwm
check_dependency wl-copy hypr
check_dependency wl-paste hypr
