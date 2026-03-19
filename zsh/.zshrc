# OS Detection
OS="$(uname -s)"

# Environment & Locale
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# Common PATHs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/kaspad/bin:$PATH"
export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

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
alias vi="vim"
alias v="nvim"
alias ls="eza --icons"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias tree="eza --tree --icons"
alias ipy="ipython"

mode_toggle() {
    local theme=$1
    local quote=$2
    local prompt=$3
    local target="$HOME/.config/ghostty/active-theme.conf"

    echo ""
    for (( i=0; i<${#quote}; i++ )); do
        echo -n "${quote:$i:1}"
        sleep 0.02
    done
    echo ""
    
    for (( i=0; i<${#prompt}; i++ )); do
        echo -n "${prompt:$i:1}"
        sleep 0.02
    done
    echo -n " [y/n]: "
    read -k 1 res
    echo ""
    
    if [[ "$res" == "y" ]]; then
        echo ""
        if [[ "$theme" == "Nord" ]]; then
            # Chaotic, scattered snow
            for (( i=0; i<8; i++ )); do
                local s1=$(( RANDOM % 15 ))
                local s2=$(( RANDOM % 20 ))
                if (( i % 2 == 0 )); then
                    printf "%${s1}s❅%${s2}s⋆\n" "" ""
                else
                    printf "%${s2}s°%${s1}s·\n" "" ""
                fi
                sleep 0.08
            done
        else
            # Tighter, solid-looking wall
            for (( i=0; i<4; i++ )); do
                local spaces=$(( RANDOM % 25 ))
                printf "%${spaces}s↟·↟\n" ""
                sleep 0.08
            done
            echo "|===|===|===|===|===|===|===|===|===|===|"
            echo "|===|===|  THE WALL STANDS  |===|===|===|"
            sleep 0.2
        fi
        echo ""

        echo "theme = $theme" > "$target"

        # Force the current instance to reload
        if [[ "$(uname)" == "Darwin" ]]; then
            osascript -e 'tell application "System Events" to tell process "Ghostty" to keystroke "," using {command down, shift down}' >/dev/null 2>&1
        else
            killall -USR2 ghostty >/dev/null 2>&1
        fi
    fi
}

alias stark="mode_toggle stark-monochrome 'Kill the boy. 🐺' 'Let the man be born? 🛡️'"
alias nord="mode_toggle Nord 'Winter is coming. ❄️' 'Now my watch begins? 🕯️'"

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

    alias brewall="(brew update && brew upgrade && brew cleanup && brew doctor)"
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
    export PATH="$HOME/.cargo/bin:$PATH"

    alias vim="vimx"
    alias sysupdate="sudo dnf upgrade --refresh -y"

    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi

# Tools
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# fzf
export FZF_DEFAULT_OPTS="
    --color=fg:#e5e9f0,bg:-1,hl:#81a1c1
    --color=fg+:#eceff4,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf616a,pointer:#b48ead
    --color=marker:#a3be8c,spinner:#b48ead,header:#5e81ac
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
export PATH="$HOME/.npm-global/bin:$PATH"
