# Suffix aliases {{{
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=mpv
alias -s git="git clone"
# }}}
# Global aliases {{{
alias -g cn=\(cd
alias -g A='| awk '
alias -g A1="| awk '{ print \$1 }' Y"
alias -g A2="| awk '{ print \$2 }' Y"
alias -g A3="| awk '{ print \$3 }' Y"
alias -g A4="| awk '{ print \$4 }' Y"
alias -g A5="| awk '{ print \$5 }' Y"
alias -g AL="| awk '{ print \$NF }' Y"
alias -g C="| cut"
alias -g C1="| cut -f1 Y"
alias -g C2="| cut -f2 Y"
alias -g C3="| cut -f3 Y"
alias -g C4="| cut -f4 Y"
alias -g C5="| cut -f5 Y"
alias -g Y='| tee >(pbcopy)'
alias -g NF='./*(oc[1])'
alias -g G='| grep'
alias -g H='| head '
alias -g T='| tail '
alias -g S='| sed '
alias -g R='| rg -i'
alias -g P='| cat'
alias -g V='| vim -'
alias -g F="| fzf " # ls -l F
alias -g X="| xargs " # ls -l X rm
# }}}
# Silly aliases {{{
alias 😀='echo "
 ⊂_ヽ
　 ＼＼
　　 ＼( ͡° ͜ʖ ͡°)
　　　 >　⌒ヽ
　　　/ 　 へ＼
　　 /　　/　＼＼
　　 ﾚ　ノ　　 ヽ_つ
　　/　/
　 /　/|
　(　(ヽ
　|　|、＼
　| 丿 ＼ ⌒)
　| |　　) /
ノ )　　Lﾉ
(_／" | lolcat'
# }}}
# Bash Shortcuts {{{
alias \?='uname -n'

alias l="eza -l --git"
alias la="eza -la --git"
alias p="pwd -P"
alias c=z
alias s="sudo -s"

alias ec=echo

alias ,=prompt_rotate

alias pp="poetry shell"
alias pr="poetry run"
alias prp="poetry run python"
alias prt="poetry run pytest"

alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias mpv2='mpv --input-conf=~/conf/mpv/input2.conf'

alias va='nvim -c "set nofixeol | set autoread | au CursorHold * checktime | call feedkeys(\"lh\")"'

alias et='exercism test'
alias es='exercism submit'
alias eo='exercism open'
alias edp='exercism download --track python --exercise'
alias edb='exercism download --track bash --exercise'

alias vp='export VAST_PORT=`vastai show instances --raw | jq ".[0].ssh_port"`'
alias vh='export VAST_HOST=`vastai show instances --raw | jq -r ".[0].ssh_host"`'
# Both at once
alias vv='export VAST_PORT=`vastai show instances --raw | jq ".[0].ssh_port"` && export VAST_HOST=`vastai show instances --raw | jq -r ".[0].ssh_host"`'
alias vs="vastai search offers 'reliability > 0.98 num_gpus = 1 gpu_ram >= 16 rented=False disk_space > 32 cuda_vers >= 12.0' -o 'dph'"
alias vsl="vastai search offers 'reliability > 0.98 num_gpus = 1 gpu_ram >= 40 rented=False disk_space > 180 cuda_vers >= 12.0' -o 'dph'"

alias ms='cd /home/ffettes/affordances/ && poetry shell && cd -'
# }}}
# Scripts {{{
# alias bu='~/c/scripts/linux/backlight.sh up'
# alias bd='~/c/scripts/linux/backlight.sh down'
# alias bm='~/c/scripts/linux/backlight.sh max'
# alias bz='~/c/scripts/linux/backlight.sh zero'
# alias bl='~/c/scripts/linux/backlight.sh lo'
# }}}
# File Shortcuts {{{
alias blog='cd /home/$USER/site-backend/ffettes'
alias mime='file --mime-type -b'

alias scratch="vi /tmp/scratch.md"

alias conf="vi -p \
$VIMRC \
$ALACRITTYRC \
/home/$USER/.tmux.conf \
/home/$USER/.zshrc \
/home/$USER/.config/personal/.zshrc.alias \
/home/$USER/.config/personal/.zshrc.vars \
/home/$USER/.config/personal/.zshrc.work \
/home/$USER/.config/personal/.zshrc.func \
/home/$USER/.sway/config \
/home/$USER/.config/regolith/i3/config"
alias zconf="vi \
/home/$USER/.zshrc \
/home/$USER/.config/personal/.zshrc.alias \
/home/$USER/.config/personal/.zshrc.vars \
/home/$USER/.config/personal/.zshrc.work \
/home/$USER/.config/personal/.zshrc.func"
alias vconf="vi $VIMRC"
alias aconf="vi $ALACRITTYRC"
alias tconf="vi /home/$USER/.tmux.conf"
# }}}
# Software Aliases {{{
alias tgl=toggl
alias tsto='toggl stop'
alias tsta='toggl start work'
alias tsu='toggl sum -t'
alias tls='toggl ls'
alias dk=docker
alias dc=docker-compose
alias dc-restart="docker-compose down && docker-compose build && docker-compose up -d && docker-compose logs -f"
alias vi=nvim
alias v="vi ."
alias vf='vi $(fzf)'

alias nt=notes
alias nto='notes open'
alias hd=hyperdrive
alias w="watch -d -n 0.2"

alias o="$EDITOR"

alias pip=pip3
alias python=python3

alias cat=bat
alias ct=rich --pager --markdown
alias bcat=/bin/cat
alias man=~/.local/bat-extras/src/batman.sh
alias grpcurl=~/.local/grpcurl
# alias fpp=~/.local/PathPicker/fpp
alias ra=ranger

alias rsync="rsync -Phav"
alias rsync_no_links="rsync -rptgoDLK"
alias rsync_remote="rsync -Phavz"

alias nk=n-kill
alias pd=python_do

alias tik=ticker

alias scim=sc-im
# }}}
# Software Shortcuts {{{
alias ghlr=last_run
alias ghrw=gh run watch

alias gl='git log --graph --decorate --oneline $(git rev-list -g --all)'
alias glp="git log -p"
alias gll="git pull"
alias gp="git push --follow-tags"
alias gs="git stash"  # overwrite ghostscript alias, its too annoying when it pops up
alias gsp="git stash pop"
alias gcaM="git commit -a --no-verify -m"
alias gcn="git clean -i"
alias gcnn="git clean -f"
alias gpt="git push --tags"
alias gg="lazygit"

alias x=exit
alias xz="exec zsh"
alias t=tmux
alias zl=zellij
alias tk="tmux attach"
alias tw="/usr/local/bin/t"
alias htop=btop
alias top="/usr/bin/htop"

alias fzf="fzf -m --bind 'tab:select-all+accept'"
# }}}
# Mini Scripts {{{
alias xio='pngpaste'
alias xi='xclip -f -sel clip'
alias xo='xclip -o -sel clip'
alias kill_ssh='kill -9 $(ps aux | rg "ssh -fN" | head -1 | tee /dev/tty | awk '\''{ print $2 }'\'')'
alias show_ssh='ps aux | rg "ssh -fN"'
alias passinfo="sed '1i\\USERNAME USER_ID GROUP_ID HOME_DIRECTORY SHELL' /etc/passwd | awk 'BEGIN { FS=\":\" } { print \$1,\$3,\$4,\$6,\$7 }' | column -t"

alias kill_something='kill -9 $(ps aux | fzf | head -1 | tee /dev/tty | awk '\''{ print $2 }'\'')'

alias ipp="echo $IP | xi"
alias cpu="watch -n 0.2 -d lscpu"
alias cpup="watch -n 0.2 'sudo cpupower frequency-info'"
# }}}
# Config Shortcuts {{{
alias rk="sk rk"
alias rk2="sk rk2"
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
# }}}
# Beads shortcuts {{{
alias bdr='bd list --ready --priority-max 1 -t task'

bdepics() {
  local data min_prio ids id_pattern
  data=$(bd list -t epic --json 2>/dev/null)
  min_prio=$(echo "$data" | jq '[.[].priority] | min')
  ids=($(echo "$data" | jq -r --argjson mp "$min_prio" '.[] | select(.priority == $mp) | .id'))
  id_pattern=$(echo "${ids[@]}" | tr ' ' '|')
  echo "Top priority epics (P${min_prio}):"
  # bd graph <id> is bugged and ignores deps; --all correctly builds full graphs
  bd graph --all --compact 2>/dev/null | awk -v pat="$id_pattern" '
    /^────/ { if (keep) printf "%s", buf; keep=0; buf=""; next }
    { buf = buf $0 "\n" }
    $0 ~ pat { keep=1 }
    END { if (keep) printf "%s", buf }
  '
}
# }}}
# Agent shortcuts {{{
alias aclaude="agent --exe claude"
alias claude="claude --dangerously-skip-permissions"
alias acodex="agent --exe codex"
alias codex="codex --dangerously-bypass-approvals-and-sandbox"
# }}}
# vim:foldmethod=marker:foldlevel=0
