# Fish Shell Configuration
# Translated from zsh dotfiles

# ============================================================================
# Environment Variables
# ============================================================================

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER /usr/bin/google-chrome

# Dynamic IP detection based on OS
if test (uname) = Darwin
    set -gx IP (ipconfig getifaddr en0 2>/dev/null; or echo "")
else if test (uname) = Linux
    set -gx IP (ip a | grep 192 | head -1 | awk '{ print $2 }' | sed -e 's/\/24$//' 2>/dev/null; or echo "")
end

# API Keys (load if files exist)
if test -f ~/pa/openai
    set -gx OPENAI_API_KEY (cat ~/pa/openai)
end
if test -f ~/pa/together
    set -gx TOGETHER_API_KEY (cat ~/pa/together)
end
if test -f ~/pa/anthropic
    set -gx ANTHROPIC_API_KEY (cat ~/pa/anthropic)
end

# Docker
set -gx DOCKER_BUILDKIT 1
set -gx COMPOSE_DOCKER_CLI_BUILD 1

# Notes
set -gx NOTES_DIRECTORY /p/journal/Notes

# Platform-specific environment
if test (uname) = Darwin
    # macOS-specific
    test -d ~/.opencode/bin; and set -gx PATH $HOME/.opencode/bin $PATH
    test -d ~/.antigravity/antigravity/bin; and set -gx PATH $HOME/.antigravity/antigravity/bin $PATH
else if test (uname) = Linux
    # Linux-specific
    test -d $HOME/worldtree/projects/llm-sandbox; and set -gx SANDBOX_REPO_ROOT $HOME/worldtree/projects/llm-sandbox
    test -d $HOME/worldtree/projects/.beads; and set -gx BEADS_DIR $HOME/worldtree/projects/.beads
end

# Common paths
test -d $HOME/bin; and set -gx PATH $HOME/bin $PATH
test -d $HOME/.cargo/bin; and set -gx PATH $HOME/.cargo/bin $PATH
test -d $HOME/.local/bin; and set -gx PATH $HOME/.local/bin $PATH

# ============================================================================
# Aliases - Essential Shortcuts
# ============================================================================

# File listing
alias l "eza -l --git"
alias la "eza -la --git"
alias p "pwd -P"

# Navigation
alias c z
alias .. "cd .."
alias ... "cd ../.."

# Editor shortcuts
alias vi nvim
alias v "nvim ."
alias vf 'nvim (fzf)'
alias o '$EDITOR'

# Better defaults
alias cat bat
alias bcat /bin/cat
alias htop btop
alias top /usr/bin/htop

# Git shortcuts
alias ga "git add"
alias gc "git commit -v"
alias gcam "git commit -a -m"
alias gcaM "git commit -a --no-verify -m"
alias gcb "git checkout -b"
alias gcm "git checkout master"
alias gco "git checkout"
alias gcn "git clean -i"
alias gcnn "git clean -f"
alias gd "git diff"
alias gg lazygit
alias gl 'git log --graph --decorate --oneline (git rev-list -g --all)'
alias glp "git log -p"
alias gll "git pull"
alias gm "git merge"
alias gp "git push --follow-tags"
alias gpt "git push --tags"
alias grhh "git reset --hard"
alias gs "git stash"
alias gsp "git stash pop"
alias gst "git status"
alias ghlr last_run
alias ghrw "gh run watch"

# Docker
alias dk docker
alias dc docker-compose
alias dc-restart "docker-compose down && docker-compose build && docker-compose up -d && docker-compose logs -f"

# Poetry
alias pp "poetry shell"
alias pr "poetry run"
alias prp "poetry run python"
alias prt "poetry run pytest"

# Python
alias pip pip3
alias python python3

# Tmux/Zellij
alias t tmux
alias tk "tmux attach"
alias zl zellij

# Misc
alias x exit
alias xz "exec fish"
alias s "sudo -s"
alias rsync "rsync -Phav"
alias rsync_remote "rsync -Phavz"
alias fzf "fzf -m --bind 'tab:select-all+accept'"
alias w "watch -d -n 0.2"

# Ranger
alias ra ranger

# Agent shortcuts
alias aclaude "agent --exe claude"
alias claude "claude --dangerously-skip-permissions"

# Clipboard (macOS)
alias xi 'pbcopy'
alias xo 'pbpaste'
alias xio 'pngpaste'

# ============================================================================
# Functions
# ============================================================================

# Continue LLM conversation
function lc
    if set -q LLM_CID
        llm --continue --cid "$LLM_CID" $argv
    else
        llm --continue $argv
    end
end

# Clipboard function - paste if terminal, copy if pipe
function cb
    if isatty stdin
        pbpaste
    else
        pbcopy
    end
end

# GitHub PR checkout with fzf
function ghpr
    set -l pr (GH_FORCE_TTY=100% gh pr list --limit 300 | \
        fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window 'down,70%' --header-lines 3 | \
        awk '{print $1}')
    if test -n "$pr"
        gh pr checkout $pr
    end
end

# Archive files
function arch
    mkdir -p .archive
    set -l NUMBER (ls .archive | wc -l | awk '{ print $1 }')
    set -l FOLDER "./.archive/$NUMBER"

    mkdir -p "$FOLDER"
    echo (date +"%Y-%m-%dT%H:%M:%S%z") > "$FOLDER/.0__ARCHIVE_DATA__"

    if test (count $argv) -gt 0
        mv -- *"$argv[1]" "$FOLDER"
    else
        echo "Usage: arch [file_extension]"
    end
end

# Python one-liner
function python_do
    if test (count $argv) -eq 1
        python3 -c "print($argv[1])"
    else if test (count $argv) -eq 2
        python3 -c "import $argv[2]; print($argv[1])"
    end
end

# Tips/notes management
function umedit
    mkdir -p ~/c/tips
    $EDITOR ~/c/tips/$argv[1].md
end

function um
    bat ~/c/tips/"$argv[1]".md
end

function umls
    ls ~/c/tips
end

function umc
    bat ~/c/tips/"$argv[1]".md | pbcopy
end

# Convert webm to gif
function webm2gif
    if test (count $argv) -eq 1
        ffmpeg -i $argv[1] -vf "fps=10,scale=320:-1:flags=lanczos" (path change-extension gif $argv[1])
    end
end

# Docker compose restart functions
function dcr
    set -l file docker-compose.yaml
    if test (count $argv) -ge 1
        set file $argv[1]
    end

    echo "stopping and restarting $file"
    docker-compose -f $file down
    docker-compose -f $file up -d
    docker-compose -f $file logs -f
end

# Recursive sed
function rsed
    if test (count $argv) -ge 2
        fd -tf $argv[2] $argv[3] -x sed -i -e "$argv[1]" {}
    end
end

# Concatenate files with headers
function fcat
    awk 'FNR==1{print "\n==> " FILENAME " <=="}1' $argv
end

# ripgrep with fzf
function rga-fzf
    set -l RG_PREFIX "rga --files-with-matches"
    set -l file (FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[1]'" \
        fzf --sort --preview="test -n {} && rga --pretty --context 5 {q} {}" \
            --phony -q "$argv[1]" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window="70%:wrap")

    if test -n "$file"
        echo "opening $file"
        open $file
    end
end

# Translation with DeepL (if you have deepl cli)
function trans
    set -l lang EN-GB
    set -l from EN-GB

    if test (count $argv) -ge 2
        set lang $argv[2]
    end
    if test (count $argv) -ge 3
        set from $argv[3]
    end

    deepl text --to="$lang" --from="$from" "$argv[1]" | pbcopy
end

# ============================================================================
# Key Bindings
# ============================================================================

# Fish uses different key binding system than zsh
# Ctrl+H - beginning of line
bind \cH beginning-of-line

# Ctrl+K - forward char
bind \cK forward-char

# Ctrl+J - forward word
bind \cJ forward-word

# Ctrl+Q - backward word
bind \cQ backward-word

# Ctrl+W - backward delete word
bind \cW backward-kill-word

# Ctrl+E - delete word
bind \cE kill-word

# Arrow up - history search backward
bind \e\[A history-search-backward
bind \eOA history-search-backward

# ============================================================================
# Tool Integrations
# ============================================================================

# Zoxide (better cd)
if type -q zoxide
    zoxide init fish | source
end

# fnm (fast node manager)
if type -q fnm
    fnm env --use-on-cd | source
end

# Starship prompt (optional - uncomment if you use it)
# if type -q starship
#     starship init fish | source
# end

# ============================================================================
# Platform-specific startup
# ============================================================================

if test (uname) = Darwin
    # Show welcome message if exists
    test -f ~/worldtree/.welcome.txt; and type -q glow; and glow ~/worldtree/.welcome.txt
end

# Suppress fish greeting
set -g fish_greeting
