#!/bin/sh

THEMES_PATH=~/.config/bspwm/themes
CURRENT_THEME_PATH="${THEMES_PATH}/theme.sh"
DEFAULT_THEME=lupan-dark

FONT=Iosevka-13.5
BAR_FONT="${FONT};5"
BAR_HEIGHT=35

CMD="$1"
shift

# Determine current theme
THEME=
if [ -e "${CURRENT_THEME_PATH}" ]; then
    . "${CURRENT_THEME_PATH}"
fi
THEME="${THEME:-$DEFAULT_THEME}"

list_themes() {
    ( cd "$THEMES_PATH" && ls *-theme.sh | sed 's/-theme.sh$//' | sort )
}

# Select next or named theme
if [ "$CMD" = theme -a "$1" = --next ]; then
    NEXT=$(list_themes | grep -A 1 "^${THEME}\$" | tail -1)
    if [ "$NEXT" = "$THEME" ]; then
	THEME=$(list_themes | head -1)
    elif [ "$THEME" = "" ]; then
	THEME="${DEFAULT_THEME}"
    else
	THEME="$NEXT"
    fi
elif [ "$CMD" = theme -a "$1" != --set ]; then
    if [ "$1" = "" ]; then
	exit
    elif [ -e "${THEMES_PATH}/$1-theme.sh" ]; then
	THEME="$1"
    else
	THEME="${DEFAULT_THEME}"
    fi
fi

# Load theme
THEME_PATH="${THEMES_PATH}/${THEME}-theme.sh"
if [ -e "${THEME_PATH}" ]; then
    . "${THEME_PATH}"
else
    . "${THEMES_PATH}/${DEFAULT_THEME}-theme.sh"
fi

DMENU_ARGS="-nb ${BAR_BG} -nf ${BAR_FG} -sb ${BAR_ACTIVE} -sf ${BAR_FG} -fn ${FONT}"

set_theme() {
    echo "THEME=${THEME}" > "${CURRENT_THEME_PATH}"
    xrdb -merge <<EOF
polybar.background: ${BAR_BG}
polybar.foreground: ${BAR_FG}
polybar.active: ${BAR_ACTIVE}
polybar.urgent: ${BAR_URGENT}
polybar.empty: ${BAR_EMPTY}
polybar.font: ${BAR_FONT}
polybar.height: ${BAR_HEIGHT}
EOF
    polybar-msg cmd restart
    xsetroot -solid "${ROOT_BG}"
    bspc config normal_border_color "${NORMAL_BORDER}"
    bspc config focused_border_color "${FOCUS_BORDER}"
    bspc config presel_feedback_color "${FOCUS_BORDER}"
    sed -i "s/^colors: [*].*/colors: *$THEME/" ~/.config/alacritty/alacritty.yml
    sed -i -E "s#(Net/ThemeName) .*#\1 \"${GTK_THEME}\"#" ~/.config/xsettingsd/xsettingsd.conf
    pkill -HUP -x xsettingsd
    emacsclient --eval "(my-select-theme '${EMACS_THEME})"
}

case "$CMD" in
    theme)
	set_theme
	;;
    dmenu|dmenu_run)
	exec "$CMD" ${DMENU_ARGS} "$@"
	;;
    dmenu_window)
	bspc node -f $(xtitle -f '%u  %s\n' $(bspc query -N -n .window) \
			   | dmenu ${DMENU_ARGS} "$@" -l 20 -i -p Window: | cut -f 1 -d ' ')
	;;
    dmenu_theme)
	sh "$0" theme $(list_themes | dmenu ${DMENU_ARGS} "$@" -p Theme:)
esac
