if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty3" ]; then
  exec sway
fi

export ZSH="/home/$USER/.oh-my-zsh"
export PATH="$PATH":/snap/bin:/home/$USER/.cargo/bin:/home/$USER/.local:/home/$USER/.local/bin:/usr/local/cuda-11.1/bin:/home/$USER/.local/node/bin

# ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "nanotech" "robbyrussell" "agnoster" "amuse" "fox" "pygmalion" "wedisagree" "strug" )
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

bindkey '^H' beginning-of-line
bindkey '^J' forward-word
bindkey '^K' forward-char
bindkey '^Q' backward-word
bindkey '^W' backward-delete-word
bindkey '^E' delete-word

# bindkey for Zsh Command Architect
bindkey '^N' zca-widget

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

,
