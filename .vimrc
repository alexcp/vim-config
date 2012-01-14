call pathogen#infect('plugin')

"do not change the current working directory
"set noautochdir

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

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
noremap <silent> <c-t> :call FindInNERDTree()<CR>

"map to CommandT
noremap <silent>T :CommandT<CR>

filetype on
"autocmd features
if has("autocmd")
  "options pour les fichiers java
  autocmd FileType java setlocal ts=8 sts=8 sw=8 expandtab
  autocmd FileType java  abbr sop System.out.println("");<esc>3ha
  autocmd FileType java  abbr ps public static
  autocmd FileType java  abbr main public static void main(String[] args){<CR>}<esc>O
  autocmd FileType java  abbr fori for(int i=0; i%; i++){<CR>}<esc>k0f%s
  autocmd FileType java  abbr if if(%){<CR>}<esc>k0f%s

  autocmd BufRead,BufNewFile *.erb abbr <% <%  %><esc>2hi
  autocmd BufRead,BufNewFile *.erb abbr <%= <%=  %><esc>2hi

  "sass as css"
  autocmd BufRead,BufNewFile *.scss set filetype=css

  "recalculate the trailing whitespace warning when idle, and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

  "recalculate the long line warning when idle and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

  "recalculate the tab warning flag when idle and after writing
  autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
endif

"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

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

"turn off needless toolbar on gvim/mvim
set guioptions-=T

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

"some stuff to get the mouse going in term
"set mouse=a
"set ttymouse=xterm2

"hide buffers when not displayed
set hidden

set guifont=Consolas\ 14

if has("gui_running")
    "tell the term has 256 colors
    set t_Co=256

    colorscheme desertEx
    set guitablabel=%M%t
    set lines=40
    set columns=115

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme desertEx
        set guifont=Consolas\ Bold\ 14
    endif

    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
else

    "set railscasts2 colorscheme when running vim in gnome terminal
    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
        "colorscheme railscasts2_term
        colorscheme desertEx
    else
        colorscheme default
    endif
endif

