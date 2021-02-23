# Load Order {{{
# Load Order    Interactive  Interactive  Script
# Startup       Only login   Always
# ------------- -----------  -----------  ------
#  /etc/zshenv       1            1         1
#    ~/.zshenv       2            2         2
# /etc/zprofile      3
#   ~/.zprofile      4
# /etc/zshrc         5            3
#   ~/.zshrc         6            4
# /etc/zlogin        7
#   ~/.zlogin        8
#
# Shutdown
# ------------- -----------  -----------  ------
#   ~/.zlogout       9
# /etc/zlogout      10
#
# Note: ZSH seems to read ~/.profile as well, if ~/.zshrc is not present.
# }}}
## Pre-init {{{
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty3" ]; then
  exec sway
fi

export ZSH="/home/$USER/.oh-my-zsh"
export PATH="$PATH":/snap/bin:/home/$USER/.cargo/bin:/home/$USER/.local:/home/$USER/.local/bin:/usr/local/cuda-11.1/bin:/home/$USER/.local/node/bin:/home/$USER/go/bin
# }}}
# Zsh init {{{
HYPHEN_INSENSITIVE="true"
plugins=(
	git
  git-flow
  python
	zsh-navigation-tools
  sudo
  # zsh-interactive-cd
  # urltools
)

source $ZSH/oh-my-zsh.sh
source ~/.antigenrc

bindkey '^H' beginning-of-line
bindkey '^J' forward-word
bindkey '^K' forward-char
bindkey '^Q' backward-word
bindkey '^W' backward-delete-word
bindkey '^E' delete-word

# bindkey for Zsh Command Architect
bindkey '^N' zca-widget
# }}}
# Env Setup {{{
if [ `uname -n` = "ondewo-xmg-01" ]; then
  source ~/.config/personal/.zshrc.work
fi
source $HOME/custom/plugins/init.sh
# Export all the environmental variables
source ~/.config/personal/.zshrc.vars
# Export all the aliases
source ~/.config/personal/.zshrc.alias
# Export all the functions
source ~/.config/personal/.zshrc.func

,

eval "$(zoxide init zsh)"
# }}}
# vim:foldmethod=marker:foldlevel=0
