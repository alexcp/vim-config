call pathogen#infect('plugin')

set nocompatible
set modelines=0
set encoding=utf-8
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

"Remapping key"
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
noremap <silent> <c-t> :call FindInNERDTree()<CR>
noremap <BS> :nohlsearch<CR>
noremap <c-l> ysaw

"run rspec on current file"
autocmd FileType ruby  noremap ,t :w\|!rspec %<cr>

"run ant
autocmd FileType java noremap ,t :! ant<cr>

"taglist"
noremap <F2> :TlistToggle<CR>

"map to CtrlP
noremap <silent>T :CtrlP<CR>

filetype on
"autocmd features
if has("autocmd")
  "options pour les fichiers java
  autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType java  abbr sop System.out.println("");<esc>3ha
  autocmd FileType java  abbr ps public static
  autocmd FileType java  abbr main public static void main(String[] args){<CR>}<esc>O
  autocmd FileType java  abbr fori for(int i=0; i%; i++){<CR>}<esc>k0f%s
  autocmd FileType java  abbr if if(%){<CR>}<esc>k0f%s

  "sass as css"
  autocmd BufRead,BufNewFile *.scss set filetype=css
endif

"java highlight
let java_mark_braces_in_parens_as_errors=1
let java_highlight_java_lang_ids=1
let java_highlight_java_io=1
let java_highlight_functions="style"

"alt-tab
noremap  <silent>ç :b#<CR>


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

"Remove the useless gui in gvim
"menu, toolbar, scrollbar
set guioptions-=m
set guioptions-=T
set guioptions-=r

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"hide buffers when not displayed
set hidden

"Display options
set guifont=Consolas\ 14
set cursorline
set enc=utf-8
set t_Co=256

"colortoggle settings
let g:default_background_type = "light"
let g:dark_colorscheme = "Tomorrow-Night"
let g:light_colorscheme = "Tomorrow"
map <silent><F5> :ToggleBg<CR>

" removing some annoying keys
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

set smartcase
set wildmode=longest,list

"fix inconsistence when yanking
nnoremap Y y$
