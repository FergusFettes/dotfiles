# FILES {{{
export ZSH="/home/$USER/.oh-my-zsh"
export EDITOR="/usr/bin/hx"

export ALACRITTYRC="/home/$USER/.config/alacritty/alacritty.yml"
export VIMRC="/home/$USER/.config/nvim/init.lua"
export MYVIMRC=$VIMRC
export ZSHRC="/home/$USER/.zshrc"

# export BROWSER="/usr/bin/nyxt"
export BROWSER="/usr/bin/google-chrome"

# }}}
# Misc vars {{{
export IP=$(ip a | grep 192 | head -1 | awk '{ print $2 }' | sed -e 's/\/24$//')
export OPENAI_API_KEY=`cat ~/pa/openai`
# }}}
# Program Vars {{{
# export BAT_THEME="zenburn"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export NOTES_DIRECTORY=/p/journal/Notes
# }}}
# Prompt stuff {{{
export ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
export ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
export ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}%{$fg[red]%} ✘ %{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔ %{$reset_color%}"

p_at='%(!.%F{red}%B#%b%f.@)'
p_host='%F{blue}%m%f'
p_path='%F{blue}%3c%f'
p_pr='%(?.%F{blue}>.%F{red}x)%f'

export RPROMPT=' %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

export MINIMAL_PROMPT='%F{grey} $%f '
export MINIMAL_RPROMPT=''

# https://solovyov.net/blog/2020/useful-shell-prompt/  consider adding name and host back if you start using remote machines a lot
export INFORMATIVE_PROMPT="$p_path$p_pr "
export INFORMATIVE_RPROMPT=''

export FULL_PROMPT=$INFORMATIVE_PROMPT
export FULL_RPROMPT=' %{$fg[blue]%}%n@%m %{$reset_color%}on $(git_prompt_info)'
export PROMPT_VERBOSITY=1
# }}}
# vim:foldmethod=marker:foldlevel=0
