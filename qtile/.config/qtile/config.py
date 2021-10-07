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
    Key([mod], "space", lazy.spawn(["rofi", "-theme", "Arc", "-kb-row-select", "Tab", "-kb-row-tab", "", "-show", "run"]), desc="Run command"),

    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Toggle between current and previous group"),
    Key([mod], "h", lazy.layout.left(), desc="Focus window on the left of current one"),
    Key([mod], "j", lazy.layout.down(), desc="Focus window below of current one"),
    Key([mod], "k", lazy.layout.up(), desc="Focus window above of current one"),
    Key([mod], "l", lazy.layout.right(), desc="Focus window on the right of current one"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Shuffle current window with the one on the left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Shuffle current window with the one below"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Shuffle current window with the one above"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Shuffle current window with the one on the right"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow current window on its left"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow current window on its bottom"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow current window on its top"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow current window on its right"),

    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
])
