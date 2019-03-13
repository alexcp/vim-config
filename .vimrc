call pathogen#infect()

set shell=zsh

set nocompatible
set modelines=0
set encoding=utf-8

""set term=screen-256color

let mapleader = ","

"quit nerdtree on file open"
let NERDTreeQuitOnOpen = 1

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the buffer is nerdtree
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

"Quit even if taglist is still open"
let Tlist_Exit_OnlyWindow = 1

"disable the mouse"
set mouse=c

"Remapping key" do
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
noremap <silent> <c-t> :NERDTreeFind<CR>
noremap <BS> :nohlsearch<CR>
noremap <c-l> ysaw
noremap <leader>h <Esc>:call ToggleHardMode()<CR>

"copy to system clipboard
noremap <leader>p "+p
noremap <leader>y "+y

" open github repo
nnoremap <leader>o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs xdg-open <CR><CR>

"Command aliases
:ca W w
:ca WQ wq
:ca Wq wq

"Gundo remap
noremap <leader>q :GundoToggle<CR>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

"run ant
autocmd FileType java noremap <leader>t :! ant<cr>

"taglist"
noremap <F2> :TlistToggle<CR>

"map to CtrlP
noremap <silent>T :CtrlP<CR>
noremap <silent>F :CtrlPBuffer<CR>

filetype on

"java"
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
let java_mark_braces_in_parens_as_errors=1
let java_highlight_java_lang_ids=1
let java_highlight_java_io=1
let java_highlight_functions="style"

"alt-tab
noremap  <silent>ç :b#<CR>
noremap ` /

" Disable quitting with ZZ
noremap ZZ Z

"remove trailling whitespace + keep cursor position"
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre *.h :call <SID>StripTrailingWhitespaces()

"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist

"add some line space for easy reading
set linespace=4

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent

filetype plugin indent on

" omnicompletion
set omnifunc=syntaxcomplete#Complete

"hide buffers when not displayed
set hidden

" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable

"Display options
syntax on
set guifont=incosolata\ 14
set cursorline
set enc=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac
set endofline

"colortoggle settings
""let g:default_background_type = "dark"
""let g:dark_colorscheme = "base16-tomorrow-night"
""let g:light_colorscheme = "sintax"
set termguicolors
colorscheme base16-tomorrow-night

" black is a custom xsession background color
autocmd VimEnter * hi Normal ctermbg=256

let base16colorspace=256  " Access colors present in 256 colorspace

" remapping some annoying keys
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
nmap j gj
nmap k gk
nnoremap Y y$
nnoremap V v$
nnoremap P :pu!<CR>

set ignorecase
set smartcase
set wildmode=longest,list
set lazyredraw
set ttyfast
set noerrorbells
set ruler
set smarttab
set expandtab

" do not include trailing \n at end of file 
set binary noeol

" CtrlP + Matcher
let g:path_to_matcher = "/usr/local/bin/matcher"

let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
let g:ctrlp_use_caching = 0

" performance improvments for ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"Easy Motion
let g:EasyMotion_leader_key = '<Leader>'

" autocomplete dash
set iskeyword+=-

" do not count dot as word
set iskeyword-=.

" allow undo even if vim was closed
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Automatically reread files that have been changed externally
set autoread

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Set the path to the ctags file
autocmd VimEnter * set tags=$PWD/.git/tags;

" Normal mode space switch to command mode
nnoremap <space> :b#<CR>

" Rename a file with <leader>n
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" run Ack against word under cursor
nnoremap <leader>g :Ack! <c-r><c-w><CR>

set timeout timeoutlen=1000 ttimeoutlen=100


" enable vim-airline all the time
set laststatus=2
let g:airline_theme='base16'
let g:airline_extensions = []
let g:airline_highlighting_cache = 1

" Wildfire plugin
nmap <leader>s <Plug>(wildfire-quick-select)

" This selects the previous closest text object.
let g:wildfire_water_map = "-"

" Rubocp mapping
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

" Convert Ruby hash syntax
function! ConvertHashSyntax()
  exec ":%s/:\([^ ]*\)\(\s*\)=>/\1:/g"
endfunction

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let loaded_matchparen = 1

set softtabstop=2 shiftwidth=2 expandtab

" rails.vim search folders
let g:rails_projections = {
  \ "app/services/*_service.rb": {
  \   "command": "service",
  \   "template":
  \     ["class {camelcase|capitalize|colons}Service"
  \      ."end"],
  \   "test": [
  \     "test/unit/services/{}_service_test.rb",
  \     "spec/services/{}_service_spec.rb"
  \   ]
  \ }}
