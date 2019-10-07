"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|
"
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

let mapleader = ","

" No backward compatibility to vi
set nocompatible

"vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'janko-m/vim-test'
Plug 'benmills/vimux'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'

Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'branch': 'release/1.x' }
Plug 'python/black'
Plug 'ruby-formatter/rufo-vim'
Plug 'mhinz/vim-mix-format'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'kchmck/vim-coffee-script'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/dbext.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

"
" Indentation
"
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"
" Syntax
"
syntax on
set showtabline=2 " Tabs immer anzeigen
set listchars=nbsp:¬,tab:»·,extends:»,precedes:«,trail:·
set list           " listchars anzeigen

"
" Spell Checking
"
map <F5> :setlocal spell! spelllang=hun-de-CH-frami<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>

"
" Line Numbers
"
set number

"
" Line Length
"
highlight ColorColumn ctermbg=magenta "set to whatever you like
call matchadd('ColorColumn', '\%101v', 100) "set column nr

"
" Filetype settings
"
filetype plugin on
filetype indent on

"
" Search
"
set incsearch
set hlsearch
set ignorecase     " Ignoriert Gross/Kleinschreibung beim Suchen
set smartcase      " Nur Gross/Kleinschreibung beachten, wenn Grossbuchstabe vorhanden
set wrapscan       " Nach dem Zeilenende weitersuchen

"
" Statusline
"
set laststatus=2
set statusline=%<%f\ %(\ [%M%R%H%Y]%)%=%-14.(%l,%c%V%)\ %P

"
" Autoreload
"
autocmd! bufwritepost .vimrc source %

"
" Persistent Undo
"
set undofile
set undodir=~/.vim/undo/

"
" Clipboard Support
"

if has('unix')
  if has('mac')       " osx
    map <C-S-C> : w ! xclip -selection clipboard<CR><CR>
    set clipboard=unnamed
  else                " linux, bsd, etc
    set clipboard+=unnamedplus
    vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
    vmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
  endif
endif

"
" Split
"
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"
" Diff
"
:set diffopt=filler,horizontal

"
" NerdTree
"
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

let NERDTreeIgnore = ['\.pyc$']

"
" fzf
"
nnoremap <silent> <C-p> :FZF -m<cr>

colorscheme sexy-railscasts-256

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" autload vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" unmap arrow keys
map <Left> :echomsg 'shame on you'<CR>
map <Right> :echomsg 'shame on you'<CR>
map <Up> :echomsg 'shame on you'<CR>
map <Down> :echomsg 'shame on you'<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Remove trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

highlight ExtraWhitespace ctermbg=red guibg=red

"
" " python mode
" let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_pep8_post_args="--max-line-length=120"
" let g:syntastic_tex_checkers = ['lacheck']

" es6 support
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

let g:airline#extensions#ale#enabled = 1
let g:airline_theme='simple'
let g:ale_linters = {'python': ['pyls']}
let g:ale_lint_on_text_changed='normal'
let g:ale_javascript_prettier_use_local_config = 1
let b:ale_fixers = {'javascript': ['prettier', 'eslint'], 'python': ['black']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'python': ['black'],
\   'ruby': ['rubocop'],
\}
let g:ale_fix_on_save = 1


" vim-test
let test#strategy = "vimux"
nnoremap <C-e> :TestFile<CR>
nnoremap <C-q> :TestNearest<CR>

" vimux
let g:VimuxHeight = "40"

" do not format code on save with vim-prettier
" call it manually with <leader>f
let g:prettier#autoformat = 0
let g:prettier#config#config_precedence = 'file-override'
nnoremap <Leader>f :Prettier<CR>


" fix delay when leaving insert mode
" see: https://www.reddit.com/r/neovim/comments/35h1g1/neovim_slow_to_respond_after_esc/
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif


let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('ale', 'rank', 999)

let g:mix_format_on_save = 1