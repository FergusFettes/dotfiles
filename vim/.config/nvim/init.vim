" Plugins {{{
call plug#begin(expand('~/.vim/plugged'))

"" Silver Searcher (note, depreciated, maybe use Ack)
Plug 'rking/ag.vim'
"" CtrlP --fuzzy file searcher
Plug 'ctrlpvim/ctrlp.vim'
"" FZF mostly used for CtrlP I guess
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"" Git-related
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

"" Fancy status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Goyo, beautiful reading mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"" Colorscheme
" Plug 'junegunn/seoul256.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sts10/vim-pink-moon'
Plug 'ayu-theme/ayu-vim'

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

"" Close buffers
Plug 'Asheq/close-buffers.vim'

" " rust
" " Vim racer
Plug 'racer-rust/vim-racer'

" YouCompleteMe
Plug 'valloric/youcompleteme'

" Repeat (for easymotion)
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'

" " Plugs I want to check out at some point:
" Plug 'skanehira/docker.vim'
" Plug 'ivanov/vim-ipython'

" Track the engine.
" Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'

" " Slimv
" Plug 'kovisoft/slimv'
"

call plug#end()
filetype plugin indent on

" }}}
" Colors {{{
if has('termguicolors')
  set termguicolors
endif

" colorscheme seoul256

" colorscheme nord

" colorscheme pink-moon
" set background=dark

" can also be 'mirage' or 'dark'
let ayucolor="mirage"
colorscheme ayu

syntax enable
set t_Co=256
set ruler


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
set number relativenumber

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3
set cursorline

filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu

set lazyredraw          " redraw only when we need to.

set showmatch           " highlight matching [{()}]
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

set foldlevelstart=4   " open most folds by default
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

" Controversial! Maybe think about it..
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Deeply radical..
" jk is escape
inoremap jk <esc>

" open ag.vim
nnoremap <leader>as :Ag!
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


"" Enter inserts empty line
map <CR> o<Esc>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Switching windows
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

" }}}
" Leader Maps {{{
"" Change fold method
nnoremap <leader>fi :set foldmethod=indent<CR>
nnoremap <leader>fm :set foldmethod=marker<CR>

"" Open, save and source vim/zsh rc files
nnoremap <leader>rc :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"" Open tips_megafile
nnoremap <leader>t :vsp $TIPS<CR>

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
nnoremap <silent> <leader>sh :terminal<CR>
nnoremap <silent> <leader>vsh :vs<Bar>:terminal<CR>

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
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
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

" turn on the experimental completer for racer
let g:racer_experimental_completer = 1

" Fix Python Path (for YCM)
let g:ycm_path_to_python_interpreter="/usr/bin/python3"

" Ale ignore

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="df"
let g:UltiSnipsJumpForwardTrigger="df"
let g:UltiSnipsJumpBackwardTrigger="fd"
let g:UltiSnipsListSnippets="sd"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Better maps for keys for easyclip
let g:EasyClipUsePasteToggleDefaults = 0

nmap <c-v> <plug>EasyClipSwapPasteForward
nmap <c-c> <plug>EasyClipSwapPasteBackwards

" }}}
" Autogroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType python setlocal commentstring=#\ %s
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

" python
au FileType python nmap <leader>rr :w<CR>:!python3 %<CR>
au FileType python nmap <leader>rp :w<CR>:!python3 %<CR>
au FileType python nmap <leader>rt :w<CR>:!python3 -m pytest %<CR>
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
" vim:foldmethod=marker:foldlevel=0
