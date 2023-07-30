# Install zap:
# % cd ~/.local/share
# % git clone https://github.com/zap-zsh/zap.git --branch=release-v1

export FZF_DEFAULT_OPTS='--color=bw,hl:green,hl+:green'
zstyle ':fzf-tab:*' fzf-flags $FZF_DEFAULT_OPTS

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/vim"

autoload -Uz compinit
compinit

plug "Aloxaf/fzf-tab"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Prompt.

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
