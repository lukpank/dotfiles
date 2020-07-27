#!/bin/sh

CMD="$1"
shift

if [ "$CMD" = theme -a "$1" = next ]; then
    case $(bspc config focused_border_color) in
	'#9fc5be') THEME=dark-blue ;;
	'#9fb3c5') THEME=dark-gray ;;
	'#4c657f') THEME=light ;;
	'#97a559') THEME=material-dark ;;
	'#78909c') THEME=material-light ;;
	*) THEME=dark ;;
    esac
elif [ "$CMD" = theme -a "$1" = "" ]; then
    exit
elif [ "$CMD" = theme ] && [ "$1" = dark -o "$1" = dark-blue -o "$1" = dark-gray -o "$1" = light -o "$1" = material-dark -o "$1" = material-light ]; then
    THEME="$1"
else
    case $(bspc config focused_border_color) in
	'#9fb3c5') THEME=dark-blue ;;
	'#4c657f') THEME=dark-gray ;;
	'#97a559') THEME=light ;;
	'#78909c') THEME=material-dark ;;
	'#b0bec5') THEME=material-light ;;
	*) THEME=dark ;;
    esac
fi

FONT=Iosevka:pixelsize=30
BAR_FONT='Iosevka:size=22:antialias=true:autohint=true;5'
BAR_HEIGHT=40

if [ "$THEME" = light ]; then
    ROOT_BG=#e5e5e5
    BAR_BG=#d8e0b7
    BAR_FG=#97a559
    BAR_ACTIVE=#ebefdb
    BAR_URGENT=#e0b7b7
    BAR_EMPTY=#7f7f7f
    NORMAL_BORDER=#7f7f7f
    FOCUS_BORDER=#97a559
    EMACS_THEME=lupan-light
    GTK_THEME=Materia-light
elif [ "$THEME" = material-light ]; then
    ROOT_BG=#fafafa
    BAR_BG=#cfd8dc
    BAR_FG=#424242
    BAR_ACTIVE=#eceff1
    BAR_URGENT=#ef5350
    BAR_EMPTY=#bdbdbd
    NORMAL_BORDER=#bdbdbd
    FOCUS_BORDER=#b0bec5
    EMACS_THEME=lupan-material-light
    GTK_THEME=Materia-light
elif [ "$THEME" = dark-blue ]; then
    ROOT_BG=#4c4c4c
    BAR_BG=#394d5f
    BAR_FG=#9fb3c5
    BAR_ACTIVE=#4c677f
    BAR_URGENT=#7f4c4c
    BAR_EMPTY=#767f88
    NORMAL_BORDER=#767f88
    FOCUS_BORDER=#9fb3c5
    EMACS_THEME=lupan-dark-blue
    GTK_THEME=Materia-dark
elif [ "$THEME" = dark-gray ]; then
    ROOT_BG=#4c4c4c
    BAR_BG=#394c5f
    BAR_FG=#9fb2c5
    BAR_ACTIVE=#4c657f
    BAR_URGENT=#7f4c4c
    BAR_EMPTY=#767f88
    NORMAL_BORDER=#767f88
    FOCUS_BORDER=#4c657f
    EMACS_THEME=lupan-dark-gray
    GTK_THEME=Materia-dark
elif [ "$THEME" = material-dark ]; then
    ROOT_BG=#212121
    BAR_BG=#455a64
    BAR_FG=#f2f6e1
    BAR_ACTIVE=#78909c
    BAR_URGENT=#ef5350
    BAR_EMPTY=#757575
    NORMAL_BORDER=#757575
    FOCUS_BORDER=#78909c
    EMACS_THEME=lupan-material-dark
    GTK_THEME=Materia-dark
else
    ROOT_BG=#4c4c4c
    BAR_BG=#395f58
    BAR_FG=#9fc5be
    BAR_ACTIVE=#4c7f75
    BAR_URGENT=#7f4c4c
    BAR_EMPTY=#768885
    NORMAL_BORDER=#768885
    FOCUS_BORDER=#9fc5be
    EMACS_THEME=lupan-dark
    GTK_THEME=Materia-dark
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
    sed -i -E "s#(Net/ThemeName) .*#\1 \"${GTK_THEME}\"#" ~/.config/xsettingsd/xsettingsd.conf
    pkill -HUP -x xsettingsd
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
	sh "$0" theme $(echo -n 'dark\ndark-blue\ndark-gray\nlight\nmaterial-dark\nmaterial-light\n' \
			    | dmenu ${DMENU_ARGS} "$@" -p Theme:)
esac
