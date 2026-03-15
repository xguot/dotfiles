# Environment & Locale
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export JAVA_HOME=$(/usr/libexec/java_home)

# PATH Configurations
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/Users/tommy/.local/bin"
export PATH="/usr/local/kaspad/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# Compiler Flags (Ruby)
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

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

# Aliases
alias c="clear"
alias brewall="(brew update && brew upgrade && brew cleanup && brew doctor)"
alias vi="nvim"
alias ls="eza --icons"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias tree="eza --tree --icons"
alias ipy="ipython"

# Plugins (Homebrew)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide
eval "$(zoxide init zsh)"

# opam
[[ ! -r '/Users/tommy/.opam/opam-init/init.zsh' ]] || source '/Users/tommy/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
eval $(opam env)

# conda
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

# starship
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
