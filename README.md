Lupan's config files
====================

Installation
------------

Install Hyprland
----------------

To reproduce my environment clone this repo into `~/dotfiles` and check
that you have required programs in your `PATH` with

```
$ sh check_dependencies.sh hypr
```

Install font `ttf-firacode-nerd` (https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip).

Install proper configurations with

```
$ stow shell hyprland alacritty xsession nvim yazi
```

Where `xsession` is just to install `lupan-set-theme` script, `nvim` and `yazi` may be skipped if you do not use them.

Change to `zsh` as your login shell with

```
$ chsh -s /usr/bin/zsh
```

Install DWM (old)
-----------------

To reproduce my environment clone this repo into `~/dotfiles` and check
that you have required programs in your `PATH` with

```
$ sh check_dependencies.sh dwm
```

Install font `ttf-firacode-nerd` (https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip).

Install `st`, `dwm`, `lupan-clock`, and config files with

```
$ make clone build install
```

Change to `zsh` as your login shell with

```
$ chsh -s /usr/bin/zsh
```
