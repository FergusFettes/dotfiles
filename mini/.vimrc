" Colors {{{
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
nnoremap <leader>fd za
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
nnoremap <leader>vs :vsp<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" mappings for quickfix list
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

" }}}
" Leader Maps {{{

"" Open, save and source vim rc files
nnoremap <leader>rc :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"" Open tips_megafile
nnoremap <leader>t :vsp $TIPS<CR>

" Spellchecker mapped to <leader>o
map <leader>o :setlocal spell! spelllang=en_us<CR>

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
nnoremap <leader>, :e %<CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

"" Help on this word
nnoremap <leader>h :h <C-R><C-W><CR>

"" Save/quit easily
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>qq :qa!<CR>
noremap <leader>qa :qa<CR>
noremap <leader>wq :wq<CR>
noremap <leader>e :e<space>

"" Save readonly
noremap <leader>fw :w !sudo tee %<CR>
noremap <leader>fwc :w !sudo tee %

"" yank to system
nnoremap <leader>y "+

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
" }}}
" vim:foldmethod=marker:foldlevel=0
