# Path to oh-my-zsh installation.
export ZSH="/home/lupan/.config/zsh/oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="lukerandall"

# Disable auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Change the command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# Change path to history file.
HISTFILE="$ZDOTDIR/.zsh_history"

# Styles.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5,underline"

# Plugins to load.
plugins=(git scd zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Directory tracking in Emacs vterm.

function vterm_printf(){
    if [ -n "$TMUX" ]; then
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
if [ "$TERM" != "dumb" ]; then
    PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
fi

# Aliases.
alias e='emacsclient -n'
