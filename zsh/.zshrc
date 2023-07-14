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
# Pre-init {{{
# if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty3" ]; then
#   exec sway
# fi

export ZSH="/home/$USER/.oh-my-zsh"
export PATH="$PATH":/snap/bin:/home/$USER/.cargo/bin:/home/$USER/.local:/home/$USER/.local/bin:/usr/local/cuda-11.1/bin:/home/$USER/.local/node/bin:/home/$USER/go/bin:/home/ffettes/.local/share/fnm:$HOME/.trigger:$HOME/dt/bin
# }}}
# Zsh init {{{
HYPHEN_INSENSITIVE="true"

source $ZSH/oh-my-zsh.sh

# Activate and check all the antigen stuff
source ~/conf/personal/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle emoji-clock
antigen bundle emoji
antigen bundle git
antigen bundle git-flow
antigen bundle web-search
antigen bundle supercrabtree/k
antigen bundle pip
antigen bundle poetry
antigen bundle python
antigen bundle sudo
antigen bundle command-not-found
antigen bundle --url=zsh-users/zsh-autosuggestions
antigen bundle z-shell/zsh-navigation-tools@main
antigen bundle fastfile

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# # Load the theme.
# antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply
# /antigen

fastfile_var_prefix=':'

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
source $HOME/enhancd/init.sh
# Export all the environmental variables
source ~/.config/personal/vars.zsh
# Export all the aliases
source ~/.config/personal/alias.zsh
# Export all the functions
source ~/.config/personal/func.zsh
# Export the work stuff
source ~/.config/personal/work.zsh

eval "$(zoxide init zsh)"

if [ `uname -n` = "ffettes-XPS15" ]; then
  source ~/.config/personal/.zshrc.work
  source ~/w/openpilot/activate.sh
  source ~/pa/openai
#   sk rk
fi

prompt_rotate

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
# }}}
# vim:foldmethod=marker:foldlevel=0

export PATH="/home/ffettes/.detaspace/bin:$PATH"

eval "$(atuin init zsh)"
