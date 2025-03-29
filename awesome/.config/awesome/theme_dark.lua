local themes_path              = require("gears.filesystem").get_themes_dir()

local xresources               = require("beautiful.xresources")
local dpi                      = xresources.apply_dpi

local theme                    = {}

theme.font                     = "Fira Code Nerd Font 10"
theme.tasklist_disable_icon    = true
theme.wibar_height             = 40

theme.bg_normal                = "#293d38" -- hsl(165deg 20% 20%)
theme.bg_focus                 = "#478575" -- hsl(165deg 30% 40%)
theme.bg_urgent                = "#5c3d45" -- hsl(345deg 20% 30%)
theme.bg_minimize              = "#363e49" -- hsl(215deg 15% 25%)
theme.bg_systray               = theme.bg_normal
theme.tasklist_bg_focus        = "#3d5c54" -- hsl(165deg 20% 30%)

theme.fg_normal                = "#a9d6ca" -- hsl(165deg 35% 75%)"
theme.fg_focus                 = "#b1babd"
theme.fg_urgent                = theme.bg_focus
theme.fg_minimize              = "#8a9294"
theme.taglist_fg_empty         = "#62847b" -- hsl(165deg 15% 45%)"

theme.useless_gap              = dpi(1)
theme.border_width             = dpi(2)
theme.border_normal            = "#708090"
theme.border_focus             = "#a0522d"
theme.border_marked            = "#91231c"

theme.bg_wallpaper             = "#424a4c"

theme.hotkeys_font             = theme.font
theme.hotkeys_description_font = theme.font
theme.hotkeys_bg               = theme.bg_minimize
theme.hotkeys_modifiers_fg     = theme.border_focus

-- You can use your own layout icons like this:
theme.layout_fairh             = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv             = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating          = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier         = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max               = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen        = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom        = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft          = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile              = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop           = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral            = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle           = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw          = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne          = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw          = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse          = themes_path .. "default/layouts/cornersew.png"

return theme
