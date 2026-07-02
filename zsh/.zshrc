### Environment & Locale
export LC_ALL=en_US.UTF-8
export EDITOR="vim"

# Linux-only Input Method variables
if [[ "$(uname)" == "Linux" ]]; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
fi

### Common PATHs
[ -f "$HOME/.zpath" ] && source "$HOME/.zpath"

# Local secrets
[ -f "$HOME/.env" ] && source "$HOME/.env"

### Shell history
HISTFILE=$HOME/.zhistory
SAVEHIST=50000
HISTSIZE=50000
setopt share_history
setopt prompt_subst
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt extendedglob

### Keybindings
bindkey -v
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

### Aliases
alias vi='vim'
alias em='emacsclient -t -a ""'
alias emc='emacsclient -c -n -a ""'
alias doom='~/.config/emacs/bin/doom'
alias di='difi'
alias wl='codewhale'

# Zsh
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# Plugin sourcing
if [ -d "/opt/homebrew/share" ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
else
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

# Homebrew for Linux (if present)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Starship Prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# Redraw prompt when clearing the screen
function clear-screen-and-scrollback() {
    zle clear-screen
    printf '\e[3J'
    zle reset-prompt
    zle redisplay
}
zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback

# Force prompt redraw when the terminal window is resized
# zle -N returns true only when ZLE is truly active (unlike [[ -o zle ]]
# which may report true during startup before ZLE is ready)
TRAPWINCH() {
  zle -N 2>/dev/null && zle reset-prompt && zle -R
}

# fzf
export FZF_DEFAULT_OPTS="
    --height 40% --layout=reverse --border
    --bind 'ctrl-/:toggle-preview'
"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then ls -la {} | head -200; else head -n 500 {}; fi'"
export FZF_CTRL_R_OPTS="--preview 'echo {2..}' --preview-window=down:3:wrap:hidden"
export FZF_ALT_C_OPTS="--preview 'ls -la {} | head -200'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=("$HOME/.juliaup/bin" $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "$HOME/.julia/juliaup/completions/zsh.zsh" ] && source "$HOME/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<


