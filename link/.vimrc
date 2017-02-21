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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/syntastic'
Plug 'kchmck/vim-coffee-script'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ervandew/supertab'
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
    set clipboard=unnamedplus
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

"
" CtrlP
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

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

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Vim Markdown
let g:vim_markdown_folding_disabled = 1
