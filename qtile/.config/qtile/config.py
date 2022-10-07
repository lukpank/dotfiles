from libqtile import bar, layout, qtile, widget
from libqtile.config import DropDown, Group, Key, KeyChord, ScratchPad, Screen
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

groups.append(
    ScratchPad("scratchpad", [
        DropDown("term", terminal),
        DropDown("thunar", "thunar"),
    ])
)

keys.extend([
    Key([mod], "F1", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "F2", lazy.group["scratchpad"].dropdown_toggle("thunar")),
])

floating_layout = layout.Floating(float_rules=[*layout.Floating.default_float_rules],
                                  **subtheme("border_width", "margin", "border_focus", "border_normal"))

layouts = [
    layout.Max(),
    layout.Columns(**subtheme("border_width", "margin", "border_focus", "border_normal")),
    layout.MonadTall(**subtheme("border_width", "margin", "border_focus", "border_normal")),
    layout.MonadWide(**subtheme("border_width", "margin", "border_focus", "border_normal")),
    layout.Matrix(**subtheme("border_width", "margin", "border_focus", "border_normal")),
    layout.Zoomy(columnwidth=200, **subtheme("border_width", "margin", "border_focus", "border_normal")),
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
        widget.CPUGraph(border_color=theme["inactive"], graph_color=theme["inactive"]),
        widget.Spacer(10),
        widget.PulseVolume(),
        widget.Spacer(10),
        widget.Clock(fontsize=s["fontsize"]),
        widget.Spacer(10),
    ], s["size"], background=theme["background"])

screens = [Screen(top=createBar(monitors.get(i))) for i in range(4)]

#fake_screens = [Screen(top=createBar(), x=x, y=y, width=1920, height=1080) for x, y in [(0, 0), (1920, 0), (0, 1080), (1920, 1080)]]

keys.extend([
    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Run terminal "),
    Key([mod, "control"], "n", lazy.spawn("emacsclient -n -c"), desc="Open new Emacs frame"),
    Key([mod], "p", lazy.spawn(["rofi", "-theme", theme["rofi_theme"], "-kb-row-tab", "", "-show", "run"]),
        desc="Run command"),
    Key([mod, "shift"], "p", lazy.spawn(["rofi", "-theme", theme["rofi_theme"], "-kb-row-tab", "", "-show", "combi"]),
        desc="Run rofi combi"),

    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "m", lazy.to_layout_index(0), desc="Switch to Max layout"),
    Key([mod, "shift"], "c", lazy.to_layout_index(1), desc="Switch to Columns layout"),
    Key([mod, "shift"], "t", lazy.to_layout_index(2), desc="Switch to MonadTall layout"),
    Key([mod, "shift"], "w", lazy.to_layout_index(3), desc="Switch to MonadWide layout"),
    Key([mod, "shift"], "r", lazy.to_layout_index(4), desc="Switch to Matrix layout"),
    Key([mod, "shift"], "z", lazy.to_layout_index(5), desc="Switch to Zoomy layout"),

    Key([mod], "a", lazy.screen.toggle_group(), desc="Toggle between current and previous group"),
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
    Key([mod], "Return", lazy.layout.toggle_split(), desc="Toggle split"),
    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left(), desc="Swap column left"),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right(), desc="Swap column right"),

    Key([mod], "g", lazy.layout.grow(), desc="Grow focused window in monad mode"),
    Key([mod], "s", lazy.layout.shrink(), desc="Shrink focused window in monad mode"),
    Key([mod], "r", lazy.layout.reset(), desc="Reset main area size"),
    Key([mod], "f", lazy.layout.flip(), desc="Flip side of secondary windows"),
    Key([mod], "m", lazy.layout.maximize(), desc="Maximize/minimize focused window in monad mode"),

    Key([mod], "i", lazy.screen.prev_group(), desc="Switch to prev group"),
    Key([mod], "o", lazy.screen.next_group(), desc="Switch to next group"),
    Key([mod, "control"], "i", lazy.prev_screen(), desc="Switch to prev screen"),
    Key([mod, "control"], "o", lazy.next_screen(), desc="Switch to next screen"),

    Key([mod], "x", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle window floating"),
    Key([mod], "e", lazy.window.toggle_maximize(), desc="Toggle window maximize"),
    Key([mod], "n", lazy.layout.normalize(), desc="Normalize layout"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle window fullscreen"),
    Key([mod, "shift"], "F6", toggle_theme, desc="Kill focused window"),

    KeyChord([mod], "semicolon", [
        Key(["shift"], "h", lazy.spawn("systemctl hibernate")),
        Key(["shift"], "l", lazy.spawn("slock")),
        Key(["shift"], "s", lazy.spawn("systemctl suspend")),
    ]),

    Key([mod, "shift"], "q", lazy.shutdown(), desc="Quit qtile"),
    Key([mod], "q", lazy.reload_config(), desc="Reload qtile config"),
])

keys.extend([Key([mod, "control"], str(i + 1), lazy.to_screen(i), desc=f"Switch to screen {i}") for i in range(len(screens))])

cursor_warp = True

apply_theme(qtile)
