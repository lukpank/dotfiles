#!/bin/sh

CMD="$1"
shift

is_light() {
    bspc config focused_border_color | grep '#068c70' > /dev/null
}

if [ "$CMD" = switch-colors ]; then
    if is_light; then
	CMD=dark-colors
	SCHEME=dark
    else
	CMD=light-colors
	SCHEME=light
    fi
elif is_light; then
    SCHEME=light
else
    SCHEME=dark
fi

FONT=Iosevka:pixelsize=30
BAR_FONT='Iosevka:pixelsize=23:antialias=true:autohint=true;5'
BAR_HEIGHT=40

if [ "$SCHEME" = light ]; then
    ROOT_BG=#c1e6c2
    BAR_BG=#e1e6d2
    BAR_FG=#1a343a
    BAR_ACTIVE=#b0decc
    BAR_URGENT=#9b0640
    BAR_EMPTY=#b0b0b0
    NORMAL_BORDER=#b0b0b0
    FOCUS_BORDER=#068c70
    EMACS_THEME=lupan-light
else
    ROOT_BG=#404040
    BAR_BG=#1a343a
    BAR_FG=#f2f6e1
    BAR_ACTIVE=#3585ce
    BAR_URGENT=#9b0640
    BAR_EMPTY=#808080
    NORMAL_BORDER=#808080
    FOCUS_BORDER=#3585ce
    EMACS_THEME=lupan-dark
fi
DMENU_ARGS="-nb ${BAR_BG} -nf ${BAR_FG} -sb ${BAR_ACTIVE} -sf ${BAR_FG} -fn $FONT"

switch_colors() {
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
    python ~/.config/alacritty/switch_bg.py "$SCHEME"
    emacsclient --eval "(my-select-theme '${EMACS_THEME})"
}

case "$CMD" in
    light-colors|dark-colors)
	switch_colors
	;;
    dmenu|dmenu_run)
	exec "$CMD" ${DMENU_ARGS} "$@"
	;;
    dmenu_window)
	bspc node -f $(xtitle -f '%u  %s\n' $(bspc query -N -n .window) \
			   | dmenu ${DMENU_ARGS} "$@" -l 20 -i | cut -f 1 -d ' ')
esac
