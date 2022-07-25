" Plugins {{{
call plug#begin(expand('~/.vim/plugged'))
  "" NERDtree
  Plug 'preservim/nerdtree' |
              \ Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'

  "" Silver Searcher (note, depreciated, maybe use Ack)
  Plug 'rking/ag.vim'
  "" CtrlP --fuzzy file searcher
  Plug 'ctrlpvim/ctrlp.vim'
  "" FZF mostly used for CtrlP I guess
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'

  "" Git-related
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  "" Fancy status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  "" Goyo, beautiful reading mode
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  "" Colorscheme
  Plug 'junegunn/seoul256.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'sts10/vim-pink-moon'
  Plug 'ayu-theme/ayu-vim'
  Plug 'ajmwagar/vim-deus'
  Plug 'scheakur/vim-scheakur'

  "" Markdown two panel
  Plug 'JamshedVesuna/vim-markdown-preview'

  "" Linter
  Plug 'dense-analysis/ale'

  "" Other
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'tpope/vim-commentary'
  Plug 'Raimondi/delimitMate'
  Plug 'sheerun/vim-polyglot'
  Plug 'mbbill/undotree'

  " SonicPi plugin
  Plug 'dermusikman/sonicpi.vim'

  " Plug 'majutsushi/tagbar'

  "" Movement
  Plug 'easymotion/vim-easymotion'
  Plug 'justinmk/vim-sneak'

  "" Close buffers
  Plug 'Asheq/close-buffers.vim'

  " " rust
  " " Vim racer
  Plug 'racer-rust/vim-racer'

  " Completion
  Plug 'valloric/youcompleteme'
  Plug 'github/copilot.vim'
  Plug 'jessfraz/openai.vim'

  " Repeat (for easymotion)
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'

  " " Plugs I want to check out at some point:
  " Plug 'skanehira/docker.vim'
  " Plug 'ivanov/vim-ipython'

  " Track the engine.
  Plug 'SirVer/ultisnips'

  " Snippets are separated from the engine. Add this if you want them:
  Plug 'honza/vim-snippets'

  " " Slimv
  " Plug 'kovisoft/slimv'

  " Python
  Plug 'pappasam/nvim-repl'

  " Table making!
  Plug 'dhruvasagar/vim-table-mode'

  " SQL dbadmin
  Plug 'tpope/vim-dadbod'

call plug#end()
filetype plugin indent on
" }}}
" Colors {{{
if has('termguicolors')
  set termguicolors
endif

" " can also be 'mirage' or 'dark'
" let ayucolor="light"|   " light_theme
" let ayucolor="mirage"
" colorscheme ayu|        " light_theme
" colorscheme seoul256
" colorscheme nord
colorscheme pink-moon|  " dark_theme

syntax enable
set t_Co=256
set ruler

set colorcolumn=120

" }}}
" Spaces & Tabs {{{
"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
" }}}
" UI Config {{{
"" Number setup to show relative number
" set number relativenumber

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3
set cursorline

filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu

set lazyredraw          " redraw only when we need to.

set showmatch           " highlight matching [{()}]
set noshowmode
" }}}
" Search {{{
"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}
" Folding {{{
set foldenable          " enable folding

set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

set foldmethod=indent   " fold based on indent level
" }}}
" Movement {{{
"
"" Map leader to ,
let mapleader=','
" set termwinkey=','

nnoremap <leader>nn :set number!<CR>
nnoremap <leader>nr :set relativenumber!<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" " Controversial! Maybe think about it..
" " move to beginning/end of line
" nnoremap B ^
" nnoremap E $
" " $/^ doesn't do anything
" nnoremap $ <nop>
" nnoremap ^ <nop>

" Deeply radical..
" jk is escape
inoremap jk <esc>
nnoremap ;1 :!
nnoremap ;12 :!<UP>

" open ag.vim
nnoremap <leader>as :Ag!

" Global Marks {{{
function! SetGMark(mark, filename, line_nr)
    let l:mybuf = bufnr(a:filename, 1)
    call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf

call SetGMark('V', '/home/ffettes/.config/nvim/init.vim', 10)
" }}}
" }}}
" Setup {{{
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Turn off swapfiles! Oh noes
set noswapfile

"" Enable hidden buffers
set hidden

set fileformats=unix,dos,mac
set shell=$SHELL

"" For single-page (aka this page) mode settings (look at bottom)
set modelines=1

"" Status bar
set laststatus=2

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Adding marks back after easyclip removed them
nnoremap gm m

" Add system clipboard as default
set clipboard=unnamed,unnamedplus

"*****************************************************************************
"" Abbreviations: I guess these are for simple spelling mistakes?
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qal qall
" }}}
" Sessions {{{
" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" }}}
" Custom Maps {{{
" open/closes folds

nnoremap <space> za
nnoremap <leader>pp :set paste!<CR>

nnoremap <leader>pc :r!date "+\%Y-\%m-\%dT\%H:\%M:\%S+01:00"<CR>kJ

"" Enter inserts empty line
map <CR> o<Esc>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Switching windows
function! TmuxMove(direction)
        let wnr = winnr()
        silent! execute 'wincmd ' . a:direction
        " If the winnr is still the same after we moved, it is the last pane
        if wnr == winnr()
                call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
        end
endfunction

nnoremap <silent> <A-h> :call TmuxMove('h')<cr>
nnoremap <silent> <A-j> :call TmuxMove('j')<cr>
nnoremap <silent> <A-k> :call TmuxMove('k')<cr>
nnoremap <silent> <A-l> :call TmuxMove('l')<cr>

tnoremap <silent> <A-h> <C-\><C-N>:call TmuxMove('h')<cr>
tnoremap <silent> <A-j> <C-\><C-N>:call TmuxMove('j')<cr>
tnoremap <silent> <A-k> <C-\><C-N>:call TmuxMove('k')<cr>
tnoremap <silent> <A-l> <C-\><C-N>:call TmuxMove('l')<cr>
inoremap <silent> <A-h> <C-\><C-N>:call TmuxMove('h')<cr>
inoremap <silent> <A-j> <C-\><C-N>:call TmuxMove('j')<cr>
inoremap <silent> <A-k> <C-\><C-N>:call TmuxMove('k')<cr>
inoremap <silent> <A-l> <C-\><C-N>:call TmuxMove('l')<cr>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nnoremap <leader>sp :sp<CR>
nnoremap <leader>vsp :vsp<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

noremap <Leader>b Oimport ipdb; ipdb.set_trace()<C-[>j
" highlight last inserted text
" nnoremap gV `[v`]

" mappings for quickfix list
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

" mapping for making a word into a markdown link
" NOTE! this is made before the 'm' is mapped to 'gm', so it has to be 'm'!
nnoremap <leader>l :let @y=@+<CR>"ryiwmhciw[r][r]<Esc>Gi[r]: y<Esc>`hE

nnoremap / ms/

nnoremap <leader>br f,bi(<CR><Esc>:s:, :,\r    :g<CR>o)<Esc>
" }}}
" Leader Maps {{{

"" NERDtree toggle
nnoremap <leader>t :NERDTreeToggle<CR>

"" Change fold method
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fm :set foldmethod=marker<CR>

"" Ctag alias
nnoremap <leader>ft "xyiw:ts <C-r>x<CR>

"" Open, save and source vim/zsh rc files
nnoremap <leader>sv :source $VIMRC<CR>

" "" Open tips_megafile
" nnoremap <leader>t :vsp $TIPS<CR>

" Spellchecker mapped to <leader>o
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Goyo map
map <leader>fk :Goyo \| set linebreak<CR>
map <leader>fj :Goyo 80% \| set linebreak<CR>

" Undotree map
nnoremap <leader>u :UndotreeToggle<cr>

" save session
nnoremap <leader>ss :mksession! ~/.vim/session/default<CR>
nnoremap <leader>s :mksession! ~/.vim/session/

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" terminal emulation
nnoremap <silent> <leader>sh :sp<Bar>:terminal<CR>
nnoremap <silent> <leader>vsh :vs<Bar>:terminal<CR>
tnoremap <silent> fg <C-\><C-N>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
nnoremap <leader>m :e %<CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Close buffer
noremap <leader>c :Bdelete menu<CR>

"" Help on this word
nnoremap <leader>h :h <C-R><C-W><CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gdi :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" FZF
noremap <leader>ff :FZF<CR>

"" Save/quit easily
" noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>qq :qa!<CR>
noremap <leader>qa :qa<CR>
noremap <leader>wq :wq<CR>
" noremap <leader>e :e<space>

"" Save readonly
noremap <leader>fw :w !sudo tee %<CR>
noremap <leader>fwc :w !sudo tee %

"" Ale next
nnoremap <backspace> :ALENext<CR>

" }}}
" CtrlP Settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'"
" }}}
" Settings for plugs {{{
"" enable clever sneak
let g:sneak#s_next = 1
nnoremap <UP> /

"" Fix for NERDtree window closing
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:ranger_map_keys = 0
noremap <leader>re :Ranger<CR>
noremap <leader>rn :RangerNewTab<CR>
" add this line if you use NERDTree
let g:NERDTreeHijackNetrw = 0
" open ranger when vim open a directory
let g:ranger_replace_netrw = 1

"" Sonic Pi Settings
nnoremap <leader>e :SonicPiStop<CR>
noremap <leader>w :w<CR>:SonicPiSendBuffer<CR>
let g:sonicpi_command = 'sonic-py-tool'
let g:sonicpi_send = 'eval-stdin'
let g:sonicpi_stop = 'stop'
let g:vim_redraw = 1

"" Markdown toggle shortcut
let vim_markdown_preview_hotkey='<leader>pm'

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"" Better Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

"" Gitgutter
let g:gitgutter_grep=''
set updatetime=500

" get rid of <s as brackets in delimitMate
let delimitMate_matchpairs = "(:),[:],{:}"
nnoremap <leader>" :DelimitMateSwitch<CR>
inoremap <C-R><C-D> <ESC>:DelimitMateSwitch<CR>i

" turn on the experimental completer for racer
let g:racer_experimental_completer = 1

" Fix Python Path (for YCM)
let g:ycm_path_to_python_interpreter="/usr/bin/python3"

" Ale ignore

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-g>"
let g:UltiSnipsJumpBackwardTrigger="<c-f>"
let g:UltiSnipsListSnippets="<c-y>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Better maps for keys for easyclip
let g:EasyClipUsePasteToggleDefaults = 0

nmap <c-v> <plug>EasyClipSwapPasteForward
nmap <c-c> <plug>EasyClipSwapPasteBackwards

" }}}
" Set registers {{{
let @g = 'gmbgggcG`bgcap`b'
let @h = 'gmvgcapgggcG`v'
" }}}
" Autogroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType sql setlocal commentstring=--\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" rust
" Vim racer
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Runs
" rust
au FileType rust nmap <leader>rr :w<CR>:!cargo run<CR>
au FileType rust nmap <leader>rs :w<CR>:!rustc %<CR>
au FileType rust nmap <leader>rw :w<CR>:!wasm-pack build<CR>
au FileType rust nmap <leader>rv :w<CR>:!cargo run --verbose<CR>

" repl
nnoremap <leader>rp :ReplToggle<CR>

" jq (json format current file):
nnoremap <leader>jq :%!jq<CR>

" python
au FileType python nmap <leader>ri :w<CR>:!python3 %<CR>
au FileType python nmap <leader>rt :w<CR>:!python3 -m pytest %<CR>
au FileType python nmap <leader>rr <Plug>ReplSendLine
au FileType python vmap <leader>re <Plug>ReplSendVisual
au FileType python vmap <leader>rr y<C-w>h""pi<CR><CR><C-\><C-N><C-w>l
au FileType python vmap <leader>rs y<C-w>h""pi<CR><CR><C-\><C-N><C-w>l
au FileType python nnoremap <leader>rs yap<C-w>h""pi<CR><CR><C-\><C-N><C-w>l
au FileType python nnoremap <leader>nq gmzA      # noqa:<ESC>`z
au FileType python nnoremap <leader>ti gmzA      # type: ignore<ESC>`z

" bash
au FileType sh nmap <leader>rr yy<C-w>h""pi<CR><C-\><C-N><C-w>l
au FileType sh vmap <leader>rr y<C-w>h""pi<CR><C-\><C-N><C-w>l
au FileType sh nnoremap <leader>rs yap<C-w>h""pi<CR><C-\><C-N><C-w>l

let g:repl_filetype_commands = {
    \ 'python': 'ipython',
    \ 'sh': 'zsh',
    \ }

" OpenAI
nmap <leader>ai :w<CR>:! /c/scripts/openai/api_wrapper.py '%:p'<CR>

" sql
au FileType sql nmap <leader>rv :w<CR>:Redir ! /c/scripts/sql/postgres_apply.sh %<CR>

" Send file to postgres
au FileType sql nmap <leader>rr :w<CR>:! /c/scripts/sql/tmux_postgres_script.sh test '%:p'<CR>
au FileType sql nmap <leader>rt :w<CR>:! /c/scripts/sql/tmux_postgres_script.sh prod '%:p'<CR>
au FileType sql nmap <leader>rl :w<CR>:! /c/scripts/sql/tmux_postgres_script.sh local '%:p'<CR>

" Send file to DB
au FileType sql nmap <leader>d :%:DB<CR>

" Send current block to postgres
au FileType sql nmap <leader>rap :let temp_filename=printf("%s%s", "/tmp/sql_script_", rand())<CR>vap'<,'>:w `=echo(temp_filename)`<CR>:! /c/scripts/sql/tmux_postgres_script.sh test echo(temp_filename)<CR>
au FileType sql nmap <leader>rap :let temp_filename=printf("%s%s", "/tmp/sql_script_", rand())<CR>vap'<,'>:w `=echo(temp_filename)`<CR>:! /c/scripts/sql/tmux_postgres_script.sh prod echo(temp_filename)<CR>

nnoremap <leader>nn :set number!<CR>
nnoremap <leader>t2 :setlocal tabstop=4<CR>:setlocal shiftwidth=4<CR>:setlocal softtabstop=4<CR>
nnoremap <leader>t4 :setlocal tabstop=4<CR>:setlocal shiftwidth=4<CR>:setlocal softtabstop=4<CR>


au FileType make nmap <leader>rr :w<CR>yiw:!make <C-R>"<CR>

au FileType requirements nmap <leader>rr :w<CR>:!pip install -r requirements.txt<CR>
" }}}
" Powerline Vars {{{
"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
" }}}
" Lynx {{{
function! s:init_lynx()
  nnoremap <nowait><buffer> <C-F> i<PageDown><C-\><C-N>
  tnoremap <nowait><buffer> <C-F> <PageDown>

  nnoremap <nowait><buffer> <C-B> i<PageUp><C-\><C-N>
  tnoremap <nowait><buffer> <C-B> <PageUp>

  nnoremap <nowait><buffer> <C-D> i:DOWN_HALF<CR><C-\><C-N>
  tnoremap <nowait><buffer> <C-D> :DOWN_HALF<CR>

  nnoremap <nowait><buffer> <C-U> i:UP_HALF<CR><C-\><C-N>
  tnoremap <nowait><buffer> <C-U> :UP_HALF<CR>

  nnoremap <nowait><buffer> <C-N> i<Delete><C-\><C-N>
  tnoremap <nowait><buffer> <C-N> <Delete>

  nnoremap <nowait><buffer> <C-P> i<Insert><C-\><C-N>
  tnoremap <nowait><buffer> <C-P> <Insert>

  nnoremap <nowait><buffer> u     i<Left><C-\><C-N>
  nnoremap <nowait><buffer> U     i<C-U><C-\><C-N>
  nnoremap <nowait><buffer> <CR>  i<CR><C-\><C-N>
  nnoremap <nowait><buffer> gg    i:HOME<CR><C-\><C-N>
  nnoremap <nowait><buffer> G     i:END<CR><C-\><C-N>
  nnoremap <nowait><buffer> zl    i:SHIFT_LEFT<CR><C-\><C-N>
  nnoremap <nowait><buffer> zL    i:SHIFT_LEFT<CR><C-\><C-N>
  nnoremap <nowait><buffer> zr    i:SHIFT_RIGHT<CR><C-\><C-N>
  nnoremap <nowait><buffer> zR    i:SHIFT_RIGHT<CR><C-\><C-N>
  nnoremap <nowait><buffer> gh    i:HELP<CR><C-\><C-N>
  nnoremap <nowait><buffer> cow   i:LINEWRAP_TOGGLE<CR><C-\><C-N>

  tnoremap <buffer> <C-C> <C-G><C-\><C-N>
  nnoremap <buffer> <C-C> i<C-G><C-\><C-N>
endfunction
command! -nargs=1 Web       vnew|call termopen('lynx -scrollbar '.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()
command! -nargs=1 Websearch vnew|call termopen('lynx -scrollbar https://duckduckgo.com/?q='.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()

" }}}
" Redir Func {{{
function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
" }}}
" vim:foldmethod=marker:foldlevel=5
