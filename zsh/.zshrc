export ZSH="/home/ffettes/.oh-my-zsh"
export PATH="$PATH":/snap/bin:/home/ffettes/.cargo/bin

# ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "nanotech" "robbyrussell" "agnoster" "amuse" "fox" "pygmalion" "wedisagree" "strug" )
HYPHEN_INSENSITIVE="true"

plugins=(
	git
    git-flow
    python
	zsh-syntax-highlighting
	zsh-autosuggestions
	zsh-navigation-tools
	k
)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/enhancd/init.sh
# source /home/ffettes/.config/broot/launcher/bash/br

if [ `uname -n` = "ondewo10" ]; then
source ~/.config/personal/.zshrc.work; fi
# Export all the environmental variables
source ~/.config/personal/.zshrc.vars
# Export all the aliases
source ~/.config/personal/.zshrc.alias
# Export all the functions
source ~/.config/personal/.zshrc.func

# User configuration

bindkey '^[n' beginning-of-line
bindkey '^[m' forward-word
bindkey '^[,' forward-char
bindkey '^[.' backward-word
bindkey '^[/' backward-delete-word
bindkey "^[\'" delete-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

,
