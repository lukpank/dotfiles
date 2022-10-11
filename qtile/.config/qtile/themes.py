import os

from colors import colors

from libqtile.lazy import lazy
from libqtile import hook, qtile

theme_file = os.path.join(os.path.dirname(__file__), "theme.txt")

def write_theme(name):
    with open(theme_file, "w") as f:
        f.write(name)

def read_theme(file_name):
    try:
        with open(file_name) as f:
            return f.read().strip()
    except FileNotFoundError:
        return "dark"

is_dark = read_theme(theme_file) == "dark"

def light_dark(light, dark):
    return dark if is_dark else light

@lazy.function
def toggle_theme(qtile):
    write_theme(light_dark("dark", "light"))
    theme = get_theme()
    qtile.restart()

background = light_dark([colors["sky"][600], colors["sky"][700]],
                        [colors["sky"][800], colors["sky"][900]])

def get_theme():
    return dict(
        border_width=4,
        margin=4,
        root_background=light_dark(colors["blue-gray"][300], colors["blue-gray"][800]),
        background=background,
        foreground=light_dark(colors["blue-gray"][100], colors["blue-gray"][400]),
        inactive=light_dark(colors["blue-gray"][400], colors["blue-gray"][500]),
        this_current_screen_border=light_dark(colors["blue-gray"][100], colors["blue-gray"][400]),
        this_screen_border=light_dark(colors["blue-gray"][400], colors["blue-gray"][500]),
        other_current_screen_border=background,
        other_screen_border=background,
        border_focus=light_dark(colors["sky"][400], colors["indigo"][600]),
        border_normal=light_dark(colors["blue-gray"][600], colors["blue-gray"][700]),
        alacritty_theme=light_dark("gogh-nord-light", "gogh-tin"),
        emacs_theme=light_dark("solarized-light", "solarized-dark"),
        gtk_theme=light_dark("Materia-light", "Materia-dark"),
        rofi_theme=light_dark("Arc", "Arc-Dark"),
    )

theme = get_theme()

def subtheme(*names):
    return {name: theme[name] for name in names}

def apply_theme(qtile):
    qtile.cmd_spawn(["xsetroot", "-solid", theme["root_background"]])
    qtile.cmd_spawn(["sed", "-i", f"s/^colors: [*].*/colors: *{theme['alacritty_theme']}/",
                     os.path.expanduser("~/.config/alacritty/alacritty.yml")])
    qtile.cmd_spawn(["emacsclient", "--eval", f"(my-select-theme '{theme['emacs_theme']})"])
    qtile.cmd_spawn(["sed", "-i", "-E", f"s#(Net/ThemeName) .*#\\1 \"{theme['gtk_theme']}\"#",
                     os.path.expanduser("~/.config/xsettingsd/xsettingsd.conf")])
    qtile.cmd_spawn(["pkill", "-HUP", "-x", "xsettingsd"])

@hook.subscribe.startup
def func():
    apply_theme(qtile)
