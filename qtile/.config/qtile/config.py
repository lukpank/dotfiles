from libqtile import bar, widget
from libqtile.config import Group, Key, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"

widget_defaults = dict(
    font="Iosevka Slab Light",
    fontsize=26,
)

keys = []

group_names = "1234567890"
groups = [Group(name) for name in group_names]
keys.extend([Key([mod], name, lazy.group[name].toscreen(toggle=False), desc=f"Switch to group {name}") for name in group_names])
keys.extend([Key([mod, "shift"], name, lazy.window.togroup(name), desc=f"Move window to group {name}") for name in group_names])

screens = [
    Screen(top=bar.Bar([
        widget.GroupBox(),
        widget.WindowName(),
        widget.Spacer(),
        widget.Clock(),
    ], 48)),
]

keys.extend([
    Key([mod], "Return", lazy.spawn(terminal), desc="Run terminal "),
    Key([mod], "e", lazy.spawn("emacsclient -n -c"), desc="Open new Emacs frame"),

    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Toggle between current and previous group"),

    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
])
