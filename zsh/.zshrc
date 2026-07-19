# Environment
export LC_ALL=en_US.UTF-8
export EDITOR="vim"

# History
HISTFILE=$HOME/.zhistory
SAVEHIST=50000
HISTSIZE=50000
setopt share_history
setopt prompt_subst
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Directory
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt extendedglob

# Keybindings
bindkey -v
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias vi='vim'
alias em='emacsclient -t -a ""'
unalias emc 2>/dev/null
emc() {
    emacsclient -c -n -a "" --eval "(when (fboundp '+doom-dashboard/open) (+doom-dashboard/open (selected-frame)))" "$@"
}
alias doom='~/.config/emacs/bin/doom'
alias wl='codewhale'

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# Plugins
if [ -d "/opt/homebrew/share" ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
else
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

# Prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --bind 'ctrl-/:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then ls -la {} | head -200; else head -n 500 {}; fi'"
export FZF_CTRL_R_OPTS="--preview 'echo {2..}' --preview-window=down:3:wrap:hidden"
export FZF_ALT_C_OPTS="--preview 'ls -la {} | head -200'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

# Julia
path=("$HOME/.juliaup/bin" $path)
export PATH
[ -f "$HOME/.julia/juliaup/completions/zsh.zsh" ] && source "$HOME/.julia/juliaup/completions/zsh.zsh"
