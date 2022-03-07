# History.

HISTFILE=${ZDOTDIR:-~}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# Prompt.

autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{magenta}(%b)%r%f '
zstyle ':vcs_info:*' enable git
PS1='%B%F{blue}%n@%m%f %F{green}%~%f%b ${vcs_info_msg_0_}%B%#%f%b '
RPROMPT='%(?..%B%F{red}%?%f%b)'

# Completion.

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Options.

setopt auto_cd
setopt extended_glob
setopt glob_complete
setopt interactive_comments
setopt no_flow_control
WORDCHARS=

# Terminal title.

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Plugins.

source_if_exists() {
    [ -e "$1" ] && source "$1"
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5,underline"
source_if_exists ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

if source_if_exists ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; then
    ZSH_HIGHLIGHT_STYLES[comment]=fg=cyan,bold
fi



# Directory stack and ls colors.

DIRSTACKSIZE=10
setopt auto_pushd pushd_minus pushd_silent pushd_to_home pushd_ignore_dups

eval $(dircolors)

# Aliases.

alias dh='dirs -v'
alias e='emacsclient -n'
alias history='history -i'
alias ls='ls --color=tty'
