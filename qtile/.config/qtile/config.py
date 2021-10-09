from libqtile import bar, layout, qtile, widget
from libqtile.config import Group, Key, KeyChord, Screen
from libqtile.lazy import lazy

from monitors import list_monitors
from themes import apply_theme, subtheme, theme, toggle_theme

mod = "mod4"
terminal = "alacritty"

hdpi_sizes = dict(size=46, fontsize=26)
hd_sizes = dict(size=32, fontsize=18)

def sizes(monitor):
    hdpi = monitor is None or max(monitor.width, monitor.height) > 2000
    return hdpi_sizes if hdpi else hd_sizes

widget_defaults = dict(
    font="Iosevka Slab Light",
    fontsize=hdpi_sizes["fontsize"],
    padding=5,
    foreground=theme["foreground"],
)

keys = []

group_names = "1234567890"
groups = [Group(name) for name in group_names]
keys.extend([Key([mod], name, lazy.group[name].toscreen(toggle=False), desc=f"Switch to group {name}") for name in group_names])
keys.extend([Key([mod, "shift"], name, lazy.window.togroup(name), desc=f"Move window to group {name}") for name in group_names])

layouts = [
    layout.Max(),
    layout.Columns(border_width=4, margin=4, **subtheme("border_focus", "border_normal")),
]

monitors = {i: m for i, m in enumerate(list_monitors())}

def createBar(monitor=None):
    s = sizes(monitor)
    return bar.Bar([
        widget.Spacer(10),
        widget.CurrentLayout(fmt="[{:3.3}]", fontsize=s["fontsize"]),
        widget.Spacer(10),
        widget.GroupBox(highlight_method='block',
                        fontsize=s["fontsize"],
                        padding_y=10,
                        active=theme["foreground"],
                        **subtheme("inactive", "this_current_screen_border", "this_screen_border",
                                   "other_current_screen_border", "other_screen_border")),
        widget.Spacer(15),
        widget.WindowName(fontsize=s["fontsize"]),
        widget.Spacer(),
        widget.Clock(fontsize=s["fontsize"]),
        widget.Spacer(10),
    ], s["size"], background=theme["background"])

screens = [Screen(top=createBar(monitors.get(i))) for i in range(4)]

#fake_screens = [Screen(top=createBar(), x=x, y=y, width=1920, height=1080) for x, y in [(0, 0), (1920, 0), (0, 1080), (1920, 1080)]]

keys.extend([
    Key([mod], "Return", lazy.spawn(terminal), desc="Run terminal "),
    Key([mod], "e", lazy.spawn("emacsclient -n -c"), desc="Open new Emacs frame"),
    Key([mod], "space", lazy.spawn(["rofi", "-theme", theme["rofi_theme"], "-kb-row-select", "Tab", "-kb-row-tab", "", "-show", "run"]),
        desc="Run command"),

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
    Key([mod], "s", lazy.window.toggle_floating(), desc="Toggle window floating"),
    Key([mod], "m", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "F6", lazy.function(toggle_theme), lazy.restart(), desc="Kill focused window"),

    KeyChord([mod], "semicolon", [
        Key(["shift"], "h", lazy.spawn("systemctl hibernate")),
        Key(["shift"], "l", lazy.spawn("slock")),
        Key(["shift"], "s", lazy.spawn("systemctl suspend")),
    ]),

    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
])

keys.extend([Key([mod, "control"], str(i + 1), lazy.to_screen(i), desc=f"Switch to screen {i}") for i in range(len(screens))])

cursor_warp = True

apply_theme(qtile)
