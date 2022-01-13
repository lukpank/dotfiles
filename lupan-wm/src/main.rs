#[macro_use]
extern crate penrose;

use clap::Parser;

use penrose::{
    contrib::{hooks::ManageExistingClients},
    core::{
        bindings::MouseEvent, config::Config, helpers::index_selectors, manager::WindowManager,
        hooks::Hooks,
        layout::{bottom_stack, side_stack, Layout, LayoutConf},
    },
    draw::{bar::dwm_bar, Color, TextStyle},
    logging_error_handler,
    xcb::{new_xcb_backed_window_manager, XcbDraw, XcbConnection},
    Backward, Forward, Less, More, Result, Selector
};

use std::convert::{TryFrom, TryInto};

pub type Conn = XcbConnection;

const TERMINAL: &str = "st tmux";
const TERMINAL2: &str = "st";
const EDITOR: &str = "emacsclient -c -n";
const SUSPEND: &str = "systemctl suspend";
const SET_THEME: &str = "lupan-set-theme";

const FONT: &str = "Iosevka Slab Light";
const FONT_SIZE: i32 = 20;
const BAR_BG: &str = "#0c4a6e";
const BAR_FG: &str = "#7dd3fc";
const BAR_HIGHLIGHT: &str = "#0369a1";
const BAR_EMPTY: &str = "#94a3b8";
const FOCUSED_BORDER: &str = "#d97706";
const UNFOCUSED_BORDER: &str = "#64748b";

#[derive(Parser, Debug)]
#[clap(about, version, author)]
struct Args {
    /// Font name
    #[clap(short, long, default_value_t = FONT.to_string())]
    font: String,

    /// Font size
    #[clap(short = 's', long, default_value_t = FONT_SIZE)]
    font_size: i32,
}

#[allow(unused_parens)]
fn main() -> Result<()> {
    let n_main = 1;
    let ratio = 0.6;
    let args = Args::parse();
    let rofi_theme_str = format!("* {{ text-color: {}; background-color: {}; blue: {}; font: \"{} {}\"; }}",
                                 BAR_FG, BAR_BG, BAR_HIGHLIGHT, args.font, args.font_size);
    let mut theme = "dark";
    let config = Config::default()
        .builder()
        .workspaces(vec!["1", "2", "3", "4", "5", "6", "7", "8", "9"])
        .bar_height((2 * args.font_size).try_into().unwrap())
        .border_px(4)
        .focused_border(FOCUSED_BORDER)?
        .unfocused_border(UNFOCUSED_BORDER)?
        .layouts(vec![
            Layout::new("[side]", LayoutConf::default(), side_stack, n_main, ratio),
            Layout::new("[botm]", LayoutConf::default(), bottom_stack, n_main, ratio),
        ])
        .build()
        .unwrap();

    let key_bindings = gen_keybindings! {
        // Program launchers
        "M-e" => run_external!(EDITOR);
        "M-space" => Box::new(move |_: &mut WindowManager<_>| spawn!(
            "rofi", "-theme", "Pop-Dark", "-theme-str", &rofi_theme_str, "-kb-row-select", "Tab", "-kb-row-tab", "Alt-Tab", "-show", "run"));
        "M-Return" => run_external!(TERMINAL);
        "M-S-Return" => run_external!(TERMINAL2);
        "M-S-s" => run_external!(SUSPEND);

        // Switch theme
        "M-S-F6" => Box::new(move |_: &mut WindowManager<_>| {
            theme = if theme == "dark" { "light" } else { "dark" };
            spawn!(SET_THEME, theme)
        });

        // Exit Penrose (important to remember this one!)
        "M-A-C-Escape" => run_internal!(exit);

        // Client management
        "M-j" => run_internal!(cycle_client, Forward);
        "M-k" => run_internal!(cycle_client, Backward);
        "M-S-j" => run_internal!(drag_client, Forward);
        "M-A-j" => run_internal!(rotate_clients, Forward);
        "M-A-k" => run_internal!(rotate_clients, Backward);
        "M-S-k" => run_internal!(drag_client, Backward);
        "M-S-f" => run_internal!(toggle_client_fullscreen, &Selector::Focused);
        "M-S-q" => run_internal!(kill_client);

        // Workspace management
        "M-Tab" => run_internal!(toggle_workspace);
        "M-period" => run_internal!(cycle_screen, Forward);
        "M-comma" => run_internal!(cycle_screen, Backward);
        "M-A-period" => run_internal!(cycle_workspace, Forward);
        "M-A-comma" => run_internal!(cycle_workspace, Backward);

        // Layout management
        "M-m" => run_internal!(cycle_layout, Forward);
        "M-S-m" => run_internal!(cycle_layout, Backward);
        "M-A-Up" => run_internal!(update_max_main, More);
        "M-A-Down" => run_internal!(update_max_main, Less);
        "M-A-Right" => run_internal!(update_main_ratio, More);
        "M-A-Left" => run_internal!(update_main_ratio, Less);
        "M-S-h" => run_internal!(update_max_main, More);
        "M-S-l" => run_internal!(update_max_main, Less);
        "M-l" => run_internal!(update_main_ratio, More);
        "M-h" => run_internal!(update_main_ratio, Less);

        map: { "1", "2", "3", "4", "5", "6", "7", "8", "9" } to index_selectors(9) => {
            "M-{}" => focus_workspace (REF);
            "M-S-{}" => client_to_workspace (REF);
        };
    };

    let mouse_bindings = gen_mousebindings! {
        Press Right + [Meta] => |wm: &mut WindowManager<_>, _: &MouseEvent| wm.cycle_workspace(Forward),
        Press Left + [Meta] => |wm: &mut WindowManager<_>, _: &MouseEvent| wm.cycle_workspace(Backward),
        Press Middle + [Meta] => |wm: &mut WindowManager<_>, _: &MouseEvent| wm.toggle_workspace(),
        Press Left + [Ctrl] => |_wm: &mut WindowManager<_>, _: &MouseEvent| penrose::core::helpers::spawn(TERMINAL)
    };

    let bar = dwm_bar(
        XcbDraw::new()?,
        (2 * args.font_size).try_into().unwrap(),
        &TextStyle {
            font: args.font,
            point_size: args.font_size,
            fg: Color::try_from(BAR_FG)?,
            bg: Some(Color::try_from(BAR_BG)?),
            padding: (12.0, 12.0),
        },
        Color::try_from(BAR_HIGHLIGHT)?, // highlight
        Color::try_from(BAR_EMPTY)?, // empty_ws
        config.workspaces().clone(),
    )?;

    let hooks: Hooks<Conn> = vec![
        ManageExistingClients::new(),
        Box::new(bar),
    ];

    let mut wm = new_xcb_backed_window_manager(config, hooks, logging_error_handler())?;
    wm.grab_keys_and_run(key_bindings, mouse_bindings)?;

    Ok(())
}
