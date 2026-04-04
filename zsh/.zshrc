# OS Detection
OS="$(uname -s)"

# Environment & Locale
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# Common PATHs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/kaspad/bin:$PATH"
export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.elan/bin:$PATH"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Local secrets
[ -f "$HOME/.env" ] && source "$HOME/.env"

# Shell history
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Common Aliases
alias c='clear'
alias m='neomutt'
alias vi='vim'
alias v='nvim'
t() {
    if [ -n "$1" ]; then
        tmux new-session -A -s "$1"
    else
        tmux new-session -A -s "$(basename $PWD) $(echo $PWD | shasum -a 256 | cut -c1-4)"
    fi
}
alias tl="tmux list-sessions -F '#{s/ [a-f0-9][a-f0-9][a-f0-9][a-f0-9]$//:session_name}' 2>/dev/null || echo 'no sessions'"
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t' 
alias ipy='ipython'
alias brewall='(brew update && brew upgrade && brew cleanup && brew doctor)'
alias gm='gemini'

# Zsh
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# macOS Specific
if [[ "$OS" == "Darwin" ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

    alias matlab='/Applications/MATLAB_R2025b.app/bin/matlab'

    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup

# Fedora Specific
elif [[ "$OS" == "Linux" ]]; then
    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    export PATH=$PATH:/home/xguo/.npm-global/bin

    alias vim="vimx"
    alias dup="sudo dnf upgrade --refresh"
    alias q-kali="qemu-system-x86_64 -m 4G -smp 4 -cpu host -accel kvm -hda ~/vms/kali/kali-disk.qcow2 -nic user,model=virtio,hostfwd=tcp::2222-:22"
    alias ku="q-kali -display none -daemonize"
    alias kg="q-kali -device intel-hda -device hda-duplex -device virtio-vga-gl -display gtk,gl=on &"
    alias ktrial="q-kali -display none -snapshot -daemonize"
    alias kd="ssh -t -p 2222 tommy@localhost 'sudo poweroff'"

    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

# Starship
eval "$(starship init zsh)"

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
