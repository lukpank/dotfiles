Lupan's config files
====================

Screenshots
-----------

Short answer: [screenshots here](https://lupan.pl/lupan-themes/).

My configuration allows to switch between my 6 themes using a shell
script bound to a key stroke (`super + F6` for switching themes in a
cycle and `super + shift + F6` for selecting one with `dmenu`).  The
theme is applied to *bspwm*, *Polybar*, *Alacritty*, *Emacs*, and
*Gtk3* (with support for reloading themes in active *Gtk3*
applications, but I currently use only two *Gtk3* themes: one dark and
one light).

You can see the screenshots of my whole workspace with each of the
themes applied on the page describing [my Emacs
themes](https://lupan.pl/lupan-themes/).  For the Emacs theme
reloading I use simple helper Emacs function `my-select-theme`
available from [Toggle between dark and light themes with a
key](https://lupan.pl/dotemacs/#toggle-between-dark-and-light-themes-with-a-key)
section of my Emacs config (also available in corresponding [GitHub
repo](https://github.com/lukpank/.emacs.d).


Installation
------------

To reproduce my environment clone this repo into `~/dotfiles` and check
that you have required programs in your `PATH` with

```
$ sh check_dependencies.sh
```

Then run

```
$ stow -v alacritty bspwm music shell tmux
```

but if you want *i3* config (left as a fallback) instead of *bspwm*
then *also* run

```
$ stow -v i3
```

Watch this video for a demo of using `stow` to manage dotfiles:
https://www.youtube.com/watch?v=TG_R7lpR2zU
