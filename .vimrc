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

"Remapping key" do
silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
noremap <silent> <c-t> :call FindInNERDTree()<CR>
noremap <BS> :nohlsearch<CR>
noremap <c-l> ysaw
noremap <leader>h <Esc>:call ToggleHardMode()<CR>

" open github repo
nnoremap <leader>o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs xdg-open<CR><CR>

"Command aliases
:ca W w
:ca WQ wq
:ca Wq wq

"Gundo remap
noremap <leader>q :GundoToggle<CR>

"run rspec on current file"
autocmd FileType ruby  noremap <leader>t :w\|!bundle exec rspec %<cr>
"run ant
autocmd FileType java noremap <leader>t :! ant<cr>

"taglist"
noremap <F2> :TlistToggle<CR>

"map to CtrlP
noremap <silent>T :CtrlP<CR>

filetype on

"java"
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
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

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent

filetype plugin on
filetype indent on

" omnicompletion
set omnifunc=syntaxcomplete#Complete

"hide buffers when not displayed
set hidden

"Display options
syntax on
set guifont=Consolas\ 14
set cursorline
set enc=utf-8
set t_Co=256

"colortoggle settings
let g:default_background_type = "dark"
let g:dark_colorscheme = "Tomorrow-Night"
let g:light_colorscheme = "sintax"

" black is a custom xsession background color
autocmd VimEnter * hi Normal ctermbg=256


" removing some annoying keys
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
nmap j gj
nmap k gk
nnoremap Y y$

set ignorecase
set smartcase
set wildmode=longest,list

" do not include trailing \n at end of file 
set binary noeol

" CtrlP + Matcher
let g:path_to_matcher = "/usr/local/bin/matcher"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")
endfunction

"Rainbow Parenteses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Easy Motion
let g:EasyMotion_leader_key = '<Leader>'

" autocomplete dash
set iskeyword+=-
