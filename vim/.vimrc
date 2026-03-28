" Unlocking the good stuff
set nocompatible

" Leader
let mapleader = " "

" Fat cursor
set guicursor=a:block

" Auto-reload
augroup ReloadConfig
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" General
set encoding=utf-8
set mouse=a
set number relativenumber
set scrolloff=8

" File navigation
nnoremap - :Explore<CR>    
let g:netrw_liststyle = 0
let g:netrw_banner = 0  " keeps it clean

" Search
set nohlsearch
set incsearch

" Indentation 
set tabstop=8
set shiftwidth=8
set softtabstop=0
set noexpandtab
set autoindent smartindent

" Editing
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Split windows
nnoremap <leader>\| :vsplit<CR>
nnoremap <leader>- :split<CR>

" Resize windows with Space + hjkl (10 units)
nnoremap <expr> <leader>k (winnr() == winnr('j') ? ':resize +10<CR>' : ':resize -10<CR>')
nnoremap <expr> <leader>j (winnr() == winnr('j') ? ':resize -10<CR>' : ':resize +10<CR>')
nnoremap <expr> <leader>h (winnr() == winnr('l') ? ':vertical resize +10<CR>' : ':vertical resize -10<CR>')
nnoremap <expr> <leader>l (winnr() == winnr('l') ? ':vertical resize -10<CR>' : ':vertical resize +10<CR>')

" Languages 
autocmd FileType go   setlocal ts=8 sw=8 sts=0 et
autocmd FileType python setlocal ts=4 sw=4 sts=4 et colorcolumn=0
let g:python_highlight_all = 1

" Tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" terminal
if has('terminal')
  tnoremap <esc> <c-\><c-n>
  tnoremap <silent> <c-h> <c-\><c-n>:tmuxnavigateleft<cr>
  tnoremap <silent> <c-j> <c-\><c-n>:tmuxnavigatedown<cr>
  tnoremap <silent> <c-k> <c-\><c-n>:tmuxnavigateup<cr>
  tnoremap <silent> <c-l> <c-\><c-n>:tmuxnavigateright<cr>
  autocmd terminalopen * setlocal nonumber norelativenumber | startinsert
endif

" fzf
nnoremap <leader>ff :FZF<CR>

" Clipboard
set clipboard=unnamedplus

if executable('wl-copy')
    let g:clipboard = {
          \   'name': 'wl-utils',
          \   'copy': { '+': 'wl-copy', '*': 'wl-copy' },
          \   'paste': { '+': 'wl-paste --no-newline', '*': 'wl-paste --no-newline' },
          \   'cache_enabled': 1,
          \ }
endif

" OS 
if has("mac")
    set rtp+=/opt/homebrew/opt/fzf
else
    " Fedora
    set rtp+=/usr/share/fzf
endif

" Colorscheme
set background=dark
syntax off
colorscheme quiet
