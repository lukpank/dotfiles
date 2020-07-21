#!/bin/sh

CMD="$1"
shift

if [ "$CMD" = theme -a "$1" = next ]; then
    case $(bspc config focused_border_color) in
	'#23aba4')
	    THEME=dark-blue
	    ;;
	'#3585ce')
	    THEME=light
	    ;;
	*)
	    THEME=dark
	    ;;
    esac
elif [ "$CMD" = theme ] && [ "$1" = dark -o "$1" = dark-blue -o "$1" = light ]; then
    THEME="$1"
else
    case $(bspc config focused_border_color) in
	'#068c70')
	    THEME=light
	    ;;
	'#3585ce')
	    THEME=dark-blue
	    ;;
	*)
	    THEME=dark
	    ;;
    esac
fi

FONT=Iosevka:pixelsize=30
BAR_FONT='Iosevka:pixelsize=23:antialias=true:autohint=true;5'
BAR_HEIGHT=40

if [ "$THEME" = light ]; then
    ROOT_BG=#c1e6c2
    BAR_BG=#e1e6d2
    BAR_FG=#1a343a
    BAR_ACTIVE=#b0decc
    BAR_URGENT=#9b0640
    BAR_EMPTY=#b0b0b0
    NORMAL_BORDER=#b0b0b0
    FOCUS_BORDER=#068c70
    EMACS_THEME=lupan-light
elif [ "$THEME" = dark-blue ]; then
    ROOT_BG=#404040
    BAR_BG=#1a343a
    BAR_FG=#f2f6e1
    BAR_ACTIVE=#3585ce
    BAR_URGENT=#9b0640
    BAR_EMPTY=#808080
    NORMAL_BORDER=#808080
    FOCUS_BORDER=#3585ce
    EMACS_THEME=lupan-dark-blue
else
    ROOT_BG=#404040
    BAR_BG=#1a343a
    BAR_FG=#f2f6e1
    BAR_ACTIVE=#23aba4
    BAR_URGENT=#9b0640
    BAR_EMPTY=#808080
    NORMAL_BORDER=#808080
    FOCUS_BORDER=#23aba4
    EMACS_THEME=lupan-dark
fi
DMENU_ARGS="-nb ${BAR_BG} -nf ${BAR_FG} -sb ${BAR_ACTIVE} -sf ${BAR_FG} -fn $FONT"

set_theme() {
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
			   | dmenu ${DMENU_ARGS} "$@" -l 20 -i | cut -f 1 -d ' ')
esac
