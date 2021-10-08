import os

from colors import colors

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

def toggle_theme(qtile):
    write_theme(light_dark("dark", "light"))

background = light_dark([colors["blue-gray"][200], colors["blue-gray"][300]],
                        [colors["blue-gray"][700], colors["blue-gray"][800]])
theme = dict(
    root_background=light_dark(colors["blue-gray"][300], colors["blue-gray"][700]),
    background=background,
    foreground=light_dark(colors["blue-gray"][600], colors["blue-gray"][400]),
    inactive=light_dark(colors["blue-gray"][400], colors["blue-gray"][500]),
    this_current_screen_border=light_dark([colors["light-blue"][200], colors["light-blue"][300]],
                                          [colors["light-blue"][800], colors["light-blue"][900]]),
    this_screen_border=light_dark([colors["blue-gray"][300], colors["blue-gray"][400]],
                                           [colors["blue-gray"][600], colors["blue-gray"][700]]),
    other_current_screen_border=background,
    other_screen_border=background,
    border_focus=light_dark(colors["indigo"][400], colors["blue-gray"][500]),
    border_normal=light_dark(colors["indigo"][900], colors["blue-gray"][800]),
    alacritty_theme=light_dark("lupan-material-light", "lupan-material-dark"),
    emacs_theme=light_dark("material-light", "material"),
    gtk_theme=light_dark("Materia-light", "Materia-dark"),
    rofi_theme=light_dark("Arc", "Arc-Dark"),
)

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
