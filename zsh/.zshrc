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

# History & Shell Options
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Common Aliases
alias c="clear"
alias ..="cd .."
alias ls="eza --icons"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias tree="eza --tree --icons"
alias vi="vim"
alias v="nvim"
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tl='tmux ls'
alias tk='tmux kill-session -t'
alias ipy="ipython"
alias brewall="(brew update && brew upgrade && brew cleanup && brew doctor)"

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

    alias vim="vimx"
    alias dup="sudo dnf upgrade --refresh"
    alias ku="qemu-system-x86_64 -m 4G -smp 4 -cpu host -accel kvm -hda ~/vms/kali/kali-disk.qcow2 -display none -nic user,model=virtio,hostfwd=tcp::2222-:22 &"
    alias kg="qemu-system-x86_64 -m 4G -smp 4 -cpu host -accel kvm -hda ~/vms/kali/kali-disk.qcow2 -device intel-hda -device hda-duplex -device virtio-vga-gl -display gtk,gl=on -nic user,model=virtio,hostfwd=tcp::2222-:22 &"
    alias kd="ssh -t -p 2222 tommy@localhost 'sudo poweroff'"

    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

# Better cd
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"

# fzf
export FZF_DEFAULT_OPTS="
    --height 40% --layout=reverse --border
    --bind 'ctrl-/:toggle-preview'
"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat --style=numbers --color=always --line-range :500 {}; fi'"
export FZF_CTRL_R_OPTS="--preview 'echo {2..} | bat --color=always --style=plain --language=sh' --preview-window=down:3:wrap:hidden"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# Vim terminal
if [[ -n "$VIM_TERMINAL" ]]; then
  export NO_COLOR=1
  export CLICOLOR=0

  unalias ls ll la tree 2>/dev/null
  
  if [[ "$OS" == "Darwin" ]]; then
    alias ls='/bin/ls'
    alias ll='/bin/ls -l'
    alias la='/bin/ls -la'
  else
    alias ls='/bin/ls --color=never'
    alias ll='/bin/ls -l --color=never'
    alias la='/bin/ls -la --color=never'
  fi

  ZSH_HIGHLIGHT_HIGHLIGHTERS=()
fi
