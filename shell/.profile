# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export EDITOR=nvim
export VISUAL=nvim

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

for dir in ~/.cargo/bin ~/go/bin ~/.local/bin ~/bin; do
    if [ -d "$dir" ]; then
	PATH="$dir:$PATH"
    fi
done

export PATH

# start X or Hyprland at login
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    if which Hyprland > /dev/null; then
        exec Hyprland
    elif which /usr/bin/sx > /dev/null; then
        exec /usr/bin/sx ~/.xsession
    fi
fi
