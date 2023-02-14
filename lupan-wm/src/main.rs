use clap::Parser;

use penrose::{
    builtin::{
        actions::{exit, log_current_state, modify_with, send_layout_message, spawn, key_handler},
        layout::{
            messages::{ExpandMain, IncMain, ShrinkMain},
            transformers::{Gaps, ReserveTop},
            MainAndStack, Monocle,
        },
    },
    core::{
        bindings::{parse_keybindings_with_xmodmap, KeyEventHandler},
        layout::LayoutStack,
        Config, WindowManager,
    },
    extensions::{hooks::add_ewmh_hooks, actions::focus_or_spawn},
    extensions::actions::toggle_fullscreen,
    map, stack,
    x11rb::RustConn,
    Result,
    util
};
use penrose_ui::{bar::Position, core::TextStyle, status_bar};
use std::collections::HashMap;
use tracing_subscriber::{self, prelude::*};

const FONT: &str = "Iosevka Slab Light";
const FONT_SIZE: i32 = 20;
const BLACK: u32 = 0x282828ff;
const WHITE: u32 = 0x7dd3fcff;
const GREY: u32 = 0x94a3b8ff;
const BLUE: u32 = 0x0c4a6eff;
const FOCUSED_BORDER: u32 = 0xd97706ff;
const NORMAL_BORDER: u32 = 0x64748ff;

const MAX_MAIN: u32 = 1;
const RATIO: f32 = 0.6;
const RATIO_STEP: f32 = 0.05;
const OUTER_PX: u32 = 5;
const INNER_PX: u32 = 5;

const TERMINAL: &str = "alacritty";
const EDITOR: &str = "emacsclient -c -n";
const SUSPEND: &str = "systemctl suspend";
const LOCK: &str = "slock";
const SET_THEME: &str = "lupan-set-theme";
const DMENU_ARGS: &[&str] = &["-fn", "Iosevka Slab Light"];

fn raw_key_bindings() -> HashMap<String, Box<dyn KeyEventHandler<RustConn>>> {
    let mut theme = "dark";
    let mut raw_bindings = map! {
        map_keys: |k: &str| k.to_owned();

        "M-j" => modify_with(|cs| cs.focus_down()),
        "M-k" => modify_with(|cs| cs.focus_up()),
        "M-S-j" => modify_with(|cs| cs.swap_down()),
        "M-S-k" => modify_with(|cs| cs.swap_up()),
        "M-S-c" => modify_with(|cs| cs.kill_focused()),
        "M-a" => modify_with(|cs| cs.toggle_tag()),
	"M-f" => toggle_fullscreen(),
	"M-Return" => modify_with(|cs| cs.swap_focus_and_head()),
	"M-m" => modify_with(|cs| cs.focus_head()),
        "M-bracketright" => modify_with(|cs| cs.next_screen()),
        "M-bracketleft" => modify_with(|cs| cs.previous_screen()),
        "M-S-bracketright" => modify_with(|cs| {
	    let current_tag = cs.current_tag().to_string();
	    cs.next_screen();
	    cs.pull_tag_to_screen(current_tag);
	}),
        "M-S-bracketleft" => modify_with(|cs| {
	    let current_tag = cs.current_tag().to_string();
	    cs.previous_screen();
	    cs.pull_tag_to_screen(current_tag);
	}),
        "M-grave" => modify_with(|cs| cs.next_layout()),
        "M-S-grave" => modify_with(|cs| cs.previous_layout()),
        "M-comma" => send_layout_message(|| IncMain(1)),
        "M-period" => send_layout_message(|| IncMain(-1)),
        "M-l" => send_layout_message(|| ExpandMain),
        "M-h" => send_layout_message(|| ShrinkMain),
        "M-p" => key_handler(move |_, _| util::spawn_with_args("dmenu_run", DMENU_ARGS)),
	"M-S-p" => spawn("rofi -theme Arc-Dark -show combi"),
	"M-S-e" => spawn(EDITOR),
        "M-S-s" => log_current_state(),
        "M-S-Return" => spawn(TERMINAL),
        "C-M-f" => focus_or_spawn("firefox", "firefox"),
        "C-M-l" => spawn(LOCK),
        "C-M-s" => spawn(SUSPEND),
        "C-M-t" => focus_or_spawn("thunderbird", "thunderbird"),
        "M-S-q" => exit(),

	"M-i" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.focus_tag((i - 1).to_string()))),
	"M-o" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.focus_tag((i + 1).to_string()))),
	"M-S-i" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.move_focused_to_tag((i - 1).to_string()))),
	"M-S-o" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.move_focused_to_tag((i + 1).to_string()))),
	"M-C-i" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.pull_tag_to_screen((i - 1).to_string()))),
	"M-C-o" => modify_with(|cs| cs.current_tag().parse::<i32>().map_or((), |i| cs.pull_tag_to_screen((i + 1).to_string()))),

        // Switch theme
        "M-S-F6" => key_handler(move |_, _| {
            theme = if theme == "dark" { "light" } else { "dark" };
            util::spawn(format!("{} {}", SET_THEME, theme))
        }),
    };

    for tag in &["1", "2", "3", "4", "5", "6", "7", "8", "9"] {
        raw_bindings.extend([
            (
                format!("M-{tag}"),
                modify_with(move |client_set| client_set.focus_tag(tag)),
            ),
            (
                format!("M-S-{tag}"),
                modify_with(move |client_set| client_set.move_focused_to_tag(tag)),
            ),
            (
                format!("M-C-{tag}"),
                modify_with(move |client_set| client_set.pull_tag_to_screen(tag)),
            ),
        ]);
    }

    raw_bindings
}

fn layouts(bar_height_px: u32) -> LayoutStack {
    stack!(
        MainAndStack::side(MAX_MAIN, RATIO, RATIO_STEP),
        MainAndStack::side_mirrored(MAX_MAIN, RATIO, RATIO_STEP),
        MainAndStack::bottom(MAX_MAIN, RATIO, RATIO_STEP),
        Monocle::boxed()
    )
    .map(|layout| ReserveTop::wrap(Gaps::wrap(layout, OUTER_PX, INNER_PX), bar_height_px))
}

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

fn main() -> Result<()> {
    let args = Args::parse();
    tracing_subscriber::fmt()
        .with_env_filter("debug")
        .finish()
        .init();
    let bar_height_px = 2 * args.font_size as u32;

    let config = add_ewmh_hooks(Config {
        default_layouts: layouts(bar_height_px),
	normal_border: NORMAL_BORDER.into(),
	focused_border: FOCUSED_BORDER.into(),
        ..Config::default()
    });

    let conn = RustConn::new()?;
    let key_bindings = parse_keybindings_with_xmodmap(raw_key_bindings())?;
    let style = TextStyle {
        font: FONT.to_string(),
        point_size: args.font_size,
        fg: WHITE.into(),
        bg: Some(BLACK.into()),
        padding: (2.0, 2.0),
    };

    let bar = status_bar(bar_height_px, &style, BLUE, GREY, Position::Top).unwrap();

    let wm = bar.add_to(WindowManager::new(
        config,
        key_bindings,
        HashMap::new(),
        conn,
    )?);

    wm.run()
}
