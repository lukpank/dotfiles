import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Grid
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.StackSet (RationalRect (RationalRect))
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

main :: IO ()
main =
  xmonad
    . docks
    . ewmh
    . ewmhFullscreen
    $ dynamicSBs barSpawner $
      myConfig

isDark = True

ifDark dark light = if isDark then dark else light

myConfig =
  def
    { modMask = mod4Mask,
      terminal = "xterm",
      borderWidth = 3,
      focusedBorderColor = ifDark "#a0522d" "#ff7f50",
      normalBorderColor = ifDark "#708090" "#bebebe",
      layoutHook = avoidStruts $ renamed [CutWordsLeft 1] $ spacingWithEdge 3 $ myLayout,
      manageHook = namedScratchpadManageHook scratchpads
    }
    `additionalKeysP` [ ("M-p", spawn "dmenu_run -fn 'Iosevka ss01-12'"),
                        ("M-S-p", spawn "rofi -theme Arc-Dark -show combi"),
                        ("M-a", toggleWS),
                        ("M-b", sendMessage ToggleStruts),
                        ("M-f", sendMessage ToggleLayout),
                        ("M-i", prevWS),
                        ("M-o", nextWS),
                        ("M-S-i", shiftToPrev),
                        ("M-S-o", shiftToNext),
                        ("M-[", prevScreen),
                        ("M-]", nextScreen),
                        ("M-S-[", shiftPrevScreen),
                        ("M-S-]", shiftNextScreen),
                        ("C-M-l", spawn "slock"),
                        ("C-M-e", spawn "emacsclient -n -c"),
                        ("C-M-s", spawn "systemctl suspend"),
                        ("M-S-<F6>", spawn switchThemeCmd *> restart "xmonad" True),
                        ("M-<F1>", namedScratchpadAction scratchpads "terminal"),
                        ("M-<F2>", namedScratchpadAction scratchpads "thunar"),
                        ("M-<F3>", namedScratchpadAction scratchpads "top")
                      ]

scratchpads =
  [ NS "terminal" "xterm -T terminal" (title =? "terminal") floating,
    NS "thunar" "thunar" (className =? "Thunar") floating,
    NS "top" "xterm -T top -e top" (title =? "top") floating
  ]
  where
    floating = customFloating $ RationalRect (1 / 6) (1 / 6) (2 / 3) (2 / 3)

myLayout = toggleLayouts Full $ tiled ||| Mirror tiled ||| Grid ||| ThreeCol 1 (3 / 100) (1 / 2) ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

barSpawner :: ScreenId -> IO StatusBarConfig
barSpawner screenId = pure (statusBarProp ("xmobar -x " ++ id ++ " -B " ++ bg ++ " -F " ++ fg) (pure myXmobarPP))
  where
    id = show $ fromEnum screenId
    bg = ifDark "'#1e293b'" "'#0c4a6e'"
    fg = ifDark "'#64748B'" "'#cbd5e1'"

myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = "  │  ",
      ppWsSep = "",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = highlight . wrap " " " ",
      ppVisible = wrap " " " " . xmobarBorder "Bottom" (ifDark "#475569" "#0ea5e9") 4,
      ppHidden = noNSP $ wrap " " " ",
      ppHiddenNoWindows = noNSP $ hidden . wrap " " " ",
      ppUrgent = red . wrap " " " "
    }
  where
    highlight, hidden, red :: String -> String
    highlight = ifDark (xmobarColor "#94A3B8" "#475569") (xmobarColor "#bae6fd" "#0284c7")
    hidden = xmobarColor (ifDark "#334155" "#9ca3af") ""
    red = xmobarColor "#111827" "#ff5555"

noNSP f name = if name /= "NSP" then f name else ""

switchThemeCmd =
  let newIsDark = show $ not isDark
      theme = ifDark "light" "dark"
      gtkTheme = ifDark "Materia-light" "Materia-dark"
      bgColor = ifDark "#dde1e3" "#4a4a4a"
   in "sed -i 's/^isDark =.*/isDark = " ++ newIsDark ++ "/' ~/.config/xmonad/xmonad.hs; "
        ++ "xsetroot -solid '"
        ++ bgColor
        ++ "'; "
        ++ "sed -i -E 's#Net/ThemeName .*#Net/ThemeName \""
        ++ gtkTheme
        ++ "\"#' ~/.config/xsettingsd/xsettingsd.conf; "
        ++ "pkill -HUP -x xsettingsd; "
        ++ "sed -i 's/^colors: [*].*/colors: *"
        ++ theme
        ++ "/' ~/.config/alacritty/alacritty.yml; "
        ++ "emacsclient --eval \"(my-select-theme '"
        ++ theme
        ++ ")\""
