# globalias() {
#   if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
#     zle _expand_alias
#     zle expand-word
#   fi
#   zle self-insert
# }
# zle -N globalias
# bindkey " " globalias # space key to expand globalalias

countdown() {
    start="$(( $(date +%s) + $1))"
    while [ "$start" -ge $(date +%s) ]; do
        ## Is this more than 24h away?
        days="$(($(($(( $start - $(date +%s) )) * 1 )) / 86400))"
        time="$(( $start - `date +%s` ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

stopwatch() {
    start=$(date +%s)
    while true; do
        days="$(($(( $(date +%s) - $start )) / 86400))"
        time="$(( $(date +%s) - $start ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

function trans() {
  # Useage
  # trans "Text to translate" [LANG] [FROMLANG]
  # Default language is English
  if [ -z $2 ]; then
    lang="EN-GB"
  else
    lang=$2
  fi

  # Default from language is English
  if [ -z $3 ]; then
    from="EN-GB"
  else
    from=$3
  fi

  deepl text --to="$lang" --from="$from" "$1" | xclip -f -selection clipboard
}

function ghpr() { GH_FORCE_TTY=100% gh pr list --limit 300 |
    fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window 'down,70%' --header-lines 3 |
    awk '{print $1}' |
    xargs gh pr checkout; 
}

function lc() {
   llm --continue "$*"
}

function oracle() {
  cat ~/chunks/oracle.txt | llm "$*"
}

function simp() {
  cat ~/chunks/simple.txt | llm "$*"
}

function unreturn() {
  xclip -selection clipboard -o | tr '\n' ' ' | tr '\r' ' ' | xclip -selection clipboard
}

function a() {
  sgpt "$*"
}

function e() {
  sgpt --shell "$*"
}

function ar() {
  # if no command, 'temp' is used
  if [ -z $1 ]; then
    cmd="temp"
  else
    cmd="$1"
  fi
  sgpt --repl "$cmd" --model gpt-4
}

function er() {
  # if no command, 'temp' is used
  if [ -z $1 ]; then
    cmd="temp"
  else
    cmd="$1"
  fi
  sgpt --repl "$cmd" --model gpt-4 --shell
}

function pic() {
  modal run ~/p/ai/modal-examples/06_gpu_and_ml/stable_diffusion/stable_diffusion_cli.py --prompt "$*"
}

function rgh() {
  (
    cd ~/da/caps/ocs/
    rga '$*'
  )
}

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

function set_xprop() {
  STR="$PWD; `date --iso=seconds`; `history -1 | sed 's/^[ ]*[0-9]*[ ]*//g'`"
  WINDOW=`xdotool getactivewindow` 2>/dev/null
  if [ -n "$WINDOW" ]; then
    xprop -id $WINDOW -f WM_CLASS 8s -set WM_CLASS "$STR"
  fi
}

# Add the function to the precmd_functions array
precmd_functions+=(set_xprop)

function aliases() {which `compgen -a` | fzf}

function mdless() {
  pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}
umedit() { mkdir -p ~/c/tips; o ~/c/tips/$1.md; }
um() { mdless ~/c/tips/"$1".md; }
umls() { ls ~/c/tips }
umc() { cat ~/c/tips/"$1".md | cb }

function webm2gif() {
  ffmpeg -i $1 -vf "fps=10,scale=320:-1:flags=lanczos" ${1%.*}.gif
}

function arch(){
  # Get the number of folders in the archive
  mkdir -p .archive
  NUMBER="`ls .archive | wc | awk '{ print $1 }'`"
  FOLDER="./.archive/$NUMBER"

  mkdir -p "$FOLDER"

  echo `date --iso-8601=minutes` > "$FOLDER/.0__ARCHIVE_DATA__"
  # If there is an argument, assume it is the file type
  mv -- *"$@" "$FOLDER"
}

function logs(){
  pipeline=$1
  if [ -z $2 ]; then
    minutes_offset=15
  else
    minutes_offset=$2
  fi

  if [ -z $3 ]; then
    pattern=Error
  else
    pattern=$3
  fi

  if [ -z $4 ]; then
    stream=''
  else
    stream="--log-stream-name \'`date +%Y/%m/%d/`[\$LATEST]$4\'"
    echo $stream
  fi

  aws logs filter-log-events \
    --start-time $((`date +%s` * 1000 - ($minutes_offset * 60 * 1000))) \
    --end-time $((`date +%s` * 1000)) \
    --log-group-name /aws/lambda/$pipeline \
    --filter-pattern $pattern \
    $stream \
    --output text
}

function logss(){
  pipeline=$1

  if [ -z $2 ]; then
    stream=''
  else
    stream="--log-stream-name `date +%Y/%m/%d/`[\$LATEST]$2"
    echo $stream
  fi

  aws logs get-log-events \
    --log-group-name /aws/lambda/$pipeline \
    $stream \
    --output text
}

function rsed2() {
  find ./ -type f -exec sed -i -e "$1" {} \;
}

function rsed() {
  fd -tf "$2" "$3" -x sed -i -e "$1" {};
}

function sk() {
  setxkbmap -layout $1 -option
  setxkbmap -layout $1 -option "caps:ctrl_modifier"
}

function venv() {
  unalias python
  unalias pip
  if [ -z $1 ]
  then
    source venv*/bin/activate
  else
    source venv-$1/bin/activate
  fi
}

function hvenv() {
  unalias python
  unalias pip
  source /h/venv*/bin/activate
}

function nvenv2(){
  python3 -m venv $2 venv-$1
  venv $1
  pip install wheel
  pip install neovim ipython "jedi==0.17.2" ipdb
}

function nvenv(){
  if [ -z $1 ]; then
    echo "No name, okay? Y/n"
    read REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Okay, creating venv."
    else
        exit 1
    fi
  fi
  virtualenv $2 venv-$1
  venv $1
  pip install neovim ipython "jedi==0.17.2" ipdb
}

function dcr-soft() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "stopping, building and restarting $file"
  if [ -z $2 ]
  then
    docker-compose -f $file down
    docker-compose -f $file build
    docker-compose -f $file up -d
    docker-compose -f $file logs -f
  else
    docker-compose -f $file --env-file $2 down
    docker-compose -f $file --env-file $2 build
    docker-compose -f $file --env-file $2 up -d
    docker-compose -f $file --env-file $2 logs -f
  fi
}

function dcr() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "stopping and restarting $file"
  if [ -z $2 ]
  then
    docker-compose -f $file down
    docker-compose -f $file up -d
    docker-compose -f $file logs -f
  else
    docker-compose -f $file --env-file $2 down
    docker-compose -f $file --env-file $2 up -d
    docker-compose -f $file --env-file $2 logs -f
  fi
}

function dcr-hard() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "killing, rming, building and restarting $file"
  if [ -z $2 ]
  then
    docker-compose -f $file kill
    docker-compose -f $file rm -f
    docker-compose -f $file build
    docker-compose -f $file up -d
    docker-compose -f $file logs -f
  else
    docker-compose -f $file --env-file $2 kill
    docker-compose -f $file --env-file $2 rm -f
    docker-compose -f $file --env-file $2 build
    docker-compose -f $file --env-file $2 up -d
    docker-compose -f $file --env-file $2 logs -f
  fi
}

function dc-down() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "rming $file"
  if [ -z $2 ]
  then
    docker-compose -f $file down
  else
    docker-compose -f $file --env-file $2 down
  fi
}

function prompt_rotate() {
  if [ $PROMPT_VERBOSITY -eq 0 ]
  then
    export PROMPT="$MINIMAL_PROMPT"
    export RPROMPT="$MINIMAL_RPROMPT"
  elif [ $PROMPT_VERBOSITY -eq 1 ]
  then
    export PROMPT="$INFORMATIVE_PROMPT"
    export RPROMPT="$INFORMATIVE_RPROMPT"
  elif [ $PROMPT_VERBOSITY -eq 2 ]
  then
    export PROMPT="$FULL_PROMPT"
    export RPROMPT="$FULL_RPROMPT"
  fi

  PROMPT_VERBOSITY=$((PROMPT_VERBOSITY + 1))
  if [ $PROMPT_VERBOSITY -gt 2 ]; then
    PROMPT_VERBOSITY=0
  fi
}

function rk_on() {
  RK_OFF=`rg "#.*sk.rk" $ZSHRC`
  if [ -z "$RK_OFF" ]
  then
    echo "was already on!"
  else
    sed -i "s/# \(.*sk rk\)/\1/" $ZSHRC
  fi
}

function rk_off() {
  RK_OFF=`rg "#.*sk.rk" $ZSHRC`
  if [ -z "$RK_OFF" ]
  then
    sed -i "s/\(.*sk rk\)/# \1/" $ZSHRC
  else
    echo "was already off!"
  fi
}

function dark() {
  ALACRITTY_LIGHT=`rg "#.{5,}dark" $ALACRITTYRC`
  if [ -z "$ALACRITTY_LIGHT" ]
  then
    echo "was already dark!"
  else
    sed -i "s/# \(.*# dark_theme\)/\1/" $ALACRITTYRC
    sed -i 's/^.*light_theme/# &/' $ALACRITTYRC
    sed -i 's/" \(.*" dark_theme\)/\1/' $VIMRC
    sed -i 's/^.*light_theme/" &/' $VIMRC
  fi

}

function light() {
  ALACRITTY_LIGHT=`rg "#.{5,}dark" $ALACRITTYRC`
  if [ -z "$ALACRITTY_LIGHT" ]
  then
    sed -i "s/# \(.*# light_theme\)/\1/" $ALACRITTYRC
    sed -i 's/^.*dark_theme/# &/' $ALACRITTYRC
    sed -i 's/" \(.*" light_theme\)/\1/' $VIMRC
    sed -i 's/^.*dark_theme/" &/' $VIMRC
  else
    echo "was already light!"
  fi
}

function python_do() {
  if [ -z $2 ]; then
    python3 -c "print($1)"
  else
    python3 -c "import $2; print($1)"
  fi
}

copilot_what-the-shell () {
  TMPFILE=$(mktemp);
  trap 'rm -f $TMPFILE' EXIT;
  if /run/user/1000/fnm_multishells/1154660_1683099828359/bin/github-copilot-cli what-the-shell "$@" --shellout $TMPFILE; then
    if [ -e "$TMPFILE" ]; then
      FIXED_CMD=$(cat $TMPFILE);
      print -s "$FIXED_CMD";
      eval "$FIXED_CMD"
    else
      echo "Apologies! Extracting command failed"
    fi
  else
    return 1
  fi
};
alias '??'='copilot_what-the-shell';

copilot_git-assist () {
  TMPFILE=$(mktemp);
  trap 'rm -f $TMPFILE' EXIT;
  if /run/user/1000/fnm_multishells/1154660_1683099828359/bin/github-copilot-cli git-assist "$@" --shellout $TMPFILE; then
    if [ -e "$TMPFILE" ]; then
      FIXED_CMD=$(cat $TMPFILE);
      print -s "$FIXED_CMD";
      eval "$FIXED_CMD"
    else
      echo "Apologies! Extracting command failed"
    fi
  else
    return 1
  fi
};
alias 'git?'='copilot_git-assist';

copilot_gh-assist () {
  TMPFILE=$(mktemp);
  trap 'rm -f $TMPFILE' EXIT;
  if /run/user/1000/fnm_multishells/1154660_1683099828359/bin/github-copilot-cli gh-assist "$@" --shellout $TMPFILE; then
    if [ -e "$TMPFILE" ]; then
      FIXED_CMD=$(cat $TMPFILE);
      print -s "$FIXED_CMD";
      eval "$FIXED_CMD"
    else
      echo "Apologies! Extracting command failed"
    fi
  else
    return 1
  fi
};
alias 'gh?'='copilot_gh-assist';
alias 'wts'='copilot_what-the-shell';
