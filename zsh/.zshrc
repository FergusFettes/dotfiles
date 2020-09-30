export ZSH="/home/$USER/.oh-my-zsh"
export PATH="$PATH":/snap/bin:/home/$USER/.cargo/bin:/home/$USER/.local:/home/$USER/.local/bin:/usr/local/cuda-11.1/bin

# ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "nanotech" "robbyrussell" "agnoster" "amuse" "fox" "pygmalion" "wedisagree" "strug" )
HYPHEN_INSENSITIVE="true"

plugins=(
	git
  git-flow
  python
	zsh-navigation-tools
  sudo
)

source $ZSH/oh-my-zsh.sh
source $HOME/custom/plugins/init.sh
source ~/.antigenrc

if [ `uname -n` = "ondewo-6" ]; then
source ~/.config/personal/.zshrc.work; fi
# Export all the environmental variables
source ~/.config/personal/.zshrc.vars
# Export all the aliases
source ~/.config/personal/.zshrc.alias
# Export all the functions
source ~/.config/personal/.zshrc.func

bindkey '^[n' beginning-of-line
bindkey '^[m' forward-word
bindkey '^[,' forward-char
bindkey '^[.' backward-word
bindkey '^[/' backward-delete-word
bindkey "^[\'" delete-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

,
