export ZSH="$USER/.zsh"
export PATH="$PATH":/snap/bin

bindkey '^[n' beginning-of-line
bindkey '^[m' forward-word
bindkey '^[,' forward-char
bindkey '^[.' backward-word
bindkey '^[/' backward-delete-word
bindkey "^[\'" delete-word

alias \?='uname -n'

alias vi=vim
alias dk=docker
alias dc=docker-compose
alias dc-restart="docker-compose down && docker-compose build && docker-compose up -d && docker-compose logs -f"
alias v="vi ."

alias gl='git log --graph --decorate --oneline $(git rev-list -g --all)'
alias glp="git log -p"
alias gll="git pull"
alias ga='git add'
alias gc='git commit -v'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gm='git merge'
alias gp='git push'
alias grhh='git reset --hard'

alias x=exit
alias xz="exec zsh"
alias t=tmux
alias tk="tmux attach"

alias l="ls -la"
alias ll="ls"

PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT=' %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
