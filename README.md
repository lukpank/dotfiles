Lupan's config files
====================

Installation
------------

To reproduce my environment clone this repo into `~/dotfiles` and check
that you have required programs in your `PATH` with

```
$ sh check_dependencies.sh
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
