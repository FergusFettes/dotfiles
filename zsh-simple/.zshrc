# Simple Oh-My-Zsh setup - slimmed down version
# Based on your existing config but with less complexity

# Path setup
export PATH="$PATH":/snap/bin:/usr/local/bin:/usr/bin:/bin:/home/ffettes/.opencode/bin:/home/ffettes/.local/share/fnm:/home/ffettes/go/bin
export EDITOR="hx"  # or vim, nano, etc.

# Oh-My-Zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # Simple, clean theme

# Essential plugins only
plugins=(
    git
    sudo
    web-search
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Basic aliases (keeping your most useful ones)
alias l="ls -la"
alias ll="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"
alias gd="git diff"

# Docker
alias dk="docker"
alias dc="docker-compose"

# Quick navigation
alias c="clear"
alias x="exit"
alias v="hx"  # or your preferred editor

# Your essential functions (keeping just the most useful)
function venv() {
    if [ -z "$1" ]; then
        source venv*/bin/activate 2>/dev/null || echo "No venv found"
    else
        source "venv-$1/bin/activate" 2>/dev/null || echo "venv-$1 not found"
    fi
}

# Node version manager (if you use it)
# eval "$(fnm env)"

# Zoxide for smart directory jumping (if installed)
# eval "$(zoxide init zsh)"

# Atuin for shell history (if installed)
# eval "$(atuin init zsh)"

# Welcome message (optional)
# echo "Welcome back to Linux! 🚀"

# Created by `pipx` on 2025-10-17 20:13:31
export PATH="$PATH:/home/ffettes/.local/bin"

# Exa API key
[ -f ~/pa/exa ] && source ~/pa/exa

# Source comprehensive aliases from dotfiles
source ~/dotfiles/zsh/.config/personal/alias.zsh
source ~/dotfiles/zsh/.config/personal/func.zsh
