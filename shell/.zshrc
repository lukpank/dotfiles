# Install zap:
# % cd ~/.local/share
# % git clone https://github.com/zap-zsh/zap.git --branch=release-v1

export FZF_DEFAULT_OPTS='--color=fg:#afb6b6,fg+:#afb6b6,bg:#264040,bg+:#58414e,hl:#9e532e,hl+:#d94426'
zstyle ':fzf-tab:*' fzf-flags $FZF_DEFAULT_OPTS

export BAT_THEME=ansi

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "jeffreytse/zsh-vi-mode"

autoload -Uz compinit
compinit

plug "Aloxaf/fzf-tab"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "MichaelAquilina/zsh-you-should-use"
plug "zsh-users/zsh-history-substring-search"
plug "agkozak/zsh-z"

ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
ZSH_HIGHLIGHT_STYLES[comment]=fg=blue
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=magenta,fg=black,bold
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=bg=red,fg=black,bold
ZSHZ_ECHO=1

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Prompt.

if which starship > /dev/null; then
    eval "$(starship init zsh)"
else
    autoload -Uz vcs_info
    precmd () { vcs_info }
    setopt prompt_subst
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats '%F{green}%r%f/%F{yellow}%S%f %F{magenta}(%b)%u%c%f '
    zstyle ':vcs_info:git:*' actionformats '%F{green}%r%f/%F{yellow}%S%f %F{magenta}(%b|%a)%u%c%f '
    zstyle ':vcs_info:*' nvcsformats '%F{green}%~%f%b '
    zstyle ':vcs_info:*' enable git
    PS1='%B%F{blue}%n@%m%f ${vcs_info_msg_0_}%B%#%f%b '
    RPROMPT='%(?..%B%F{red}%?%f%b)'
fi

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

# Convenience.

setopt autocd
bindkey -M vicmd '^[h' run-help
bindkey -M viins '^[h' run-help

setopt glob_complete
setopt interactive_comments

# Aliases.

for f in ~/.config/shellconfig/*.sh(N) ~/.config/shellconfig/*.zsh(N); do source "$f"; done
