local themes_path           = require("gears.filesystem").get_themes_dir()

local xresources            = require("beautiful.xresources")
local dpi                   = xresources.apply_dpi

local theme                 = {}

theme.font                  = "FiraCode Nerd Font Ret:size=10"
theme.tasklist_disable_icon = true
theme.wibar_height          = 40

theme.bg_normal             = "#0c4a6e"
theme.bg_focus              = "#0284c7"
theme.bg_urgent             = "#ff5555"
theme.bg_minimize           = "#444444"
theme.bg_systray            = theme.bg_normal
theme.tasklist_bg_focus     = "#075985"

theme.fg_normal             = "#cbd5e1"
theme.fg_focus              = "#bae6fd"
theme.fg_urgent             = "#111827"
theme.fg_minimize           = "#ffffff"
theme.taglist_fg_empty      = "#9ca3af"

theme.useless_gap           = dpi(1)
theme.border_width          = dpi(2)
theme.border_normal         = "#bebebe"
theme.border_focus          = "#ff7f50"
theme.border_marked         = "#91231c"

theme.bg_wallpaper          = "#dde1e3"

-- You can use your own layout icons like this:
theme.layout_fairh          = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv          = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating       = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier      = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max            = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen     = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom     = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft       = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile           = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop        = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral         = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle        = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw       = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne       = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw       = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse       = themes_path .. "default/layouts/cornersew.png"

return theme
