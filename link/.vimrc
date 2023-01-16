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

" allow file type specific options, see .vim/ftplugin/
filetype plugin on
filetype plugin indent on

" No backward compatibility to vi
set nocompatible

"vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'janko-m/vim-test'
Plug 'benmills/vimux'
Plug 'tpope/vim-sleuth'

Plug 'sainnhe/gruvbox-material'
Plug 'vim-scripts/Color-Scheme-Explorer'
Plug 'sonph/onehalf'

Plug 'kchmck/vim-coffee-script'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/dbext.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ElmCast/elm-vim'
Plug 'pearofducks/ansible-vim'

" for react
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pearofducks/ansible-vim'

Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'tpope/vim-commentary'
Plug 'lfv89/vim-interestingwords'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'eandrju/cellular-automaton.nvim'

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
call matchadd('ColorColumn', '\%121v', 120) "set column nr

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

" WSL use win32yank
if !empty(matchstr(system("uname -a"), "microsoft"))
   let g:clipboard = {
       \ 'name': 'win32yank',
       \ 'copy': {
       \   '+': 'win32yank.exe -i --crlf',
       \   '*': 'win32yank.exe -i --crlf',
       \   },
       \ 'paste': {
       \   '+': 'win32yank.exe -o --lf',
       \   '*': 'win32yank.exe -o --lf',
       \   },
       \ 'cache_enabled': 1,
       \ }
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
:let g:NERDTreeWinSize=60

let NERDTreeIgnore = ['\.pyc$', '__pycache__']

"
" fzf
"
nnoremap <silent> <C-p> :FZF -m<cr>

set background=dark
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material
hi! link ErrorText ErrorMsg
hi! SpellBad cterm=underline gui=underline guisp=#ea6962
hi! link SpellCap SpellBad
hi! link SpellRare SpellBad
hi! link SpellLocal SpellBad
hi! WarningText cterm=underline gui=underline guisp=#d8a657
hi! InfoText cterm=underline gui=underline guisp=#d8a657
hi! HintText cterm=underline gui=underline guisp=#a9b665

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

" vim-jsx-typescript
let g:vim_jsx_pretty_colorful_config = 1

" vim-test
let test#strategy = "vimux"
nnoremap <C-e> :TestFile<CR>
nnoremap <C-q> :TestNearest<CR>

" vimux
let g:VimuxHeight = "40"

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

"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#source('ale', 'rank', 999)


" add import pdb; pdb.set_trace() with <Leader>d
map <Leader>p :call InsertLine()<CR>
function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal o".trace
endfunction




" install coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-stylelint', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-solargraph', 'coc-tailwindcss', 'coc-html', 'coc-pyright', 'coc-yaml', 'coc-spell-checker', 'coc-cspell-dicts', 'coc-htmldjango', 'coc-solidity', "coc-elixir"]

"""""" EXAMPLE CONFIGURATION FROM coc plugin """""

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" -----------------------------------------------------------------------------
" from https://github.com/neoclide/coc.nvim/issues/4155#issuecomment-1238586683
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" -----------------------------------------------------------------------------

" Use `[p` and `]p` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> dp <Plug>(coc-diagnostic-prev)
nmap <silent> dn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-cursor)
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


nmap <Leader>U :CocCommand git.chunkUndo<CR>
nmap <Leader>og :CocCommand git.toggleGutters<CR>
nmap <Leader>h :call CocAction('doHover')<CR>

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" isort on save
autocmd BufWritePre *.py silent! :call CocAction('runCommand', 'python.sortImports')

" disable mouse
set mouse=

" see https://github.com/Eandrju/cellular-automaton.nvim
nmap <Leader>) :CellularAutomaton make_it_rain<CR>
nmap <Leader>(f :CellularAutomaton game_of_life<CR>
