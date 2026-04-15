" Unlocking the good stuff
set nocompatible

" Leader
let mapleader = " "

" Auto-reload
augroup ReloadConfig
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" Colorscheme
set background=dark
syntax off
colorscheme quiet

" Fat cursor
set guicursor=a:block

" General
set encoding=utf-8
set mouse=a
set number relativenumber
set scrolloff=8

" 4-space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Clipboard
if has('mac') || has('macunix')
    " macOS uses the * register for the system clipboard
    set clipboard=unnamed
else
    " Linux uses the + register
    set clipboard=unnamedplus
endif

if has('nvim')
    if executable('wl-copy')
        let g:clipboard = {
              \   'name': 'wl-utils',
              \   'copy': { '+': 'wl-copy', '*': 'wl-copy' },
              \   'paste': { '+': 'wl-paste --no-newline', '*': 'wl-paste --no-newline' },
              \   'cache_enabled': 1,
              \ }
    endif
endif

" File navigation
nnoremap - :Explore<CR>    
let g:netrw_liststyle = 0
let g:netrw_banner = 0  " keeps it clean

" Search
set incsearch
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" Split windows
nnoremap <leader>% :vsplit<CR>
nnoremap <leader>" :split<CR>

" Resize windows with Space + hjkl (10 units)
nnoremap <expr> <leader>k (winnr() == winnr('j') ? ':resize +10<CR>' : ':resize -10<CR>')
nnoremap <expr> <leader>j (winnr() == winnr('j') ? ':resize -10<CR>' : ':resize +10<CR>')
nnoremap <expr> <leader>h (winnr() == winnr('l') ? ':vertical resize +10<CR>' : ':vertical resize -10<CR>')
nnoremap <expr> <leader>l (winnr() == winnr('l') ? ':vertical resize -10<CR>' : ':vertical resize +10<CR>')

" Editing
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

augroup HighlightYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
augroup END

" Languages 
autocmd FileType go setlocal ts=8 sw=8 sts=0 noexpandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact,svelte setlocal ts=2 sw=2 sts=2 expandtab

" Git
nnoremap <leader>gs :Git<CR>

" OS 
if has("mac")
    set rtp+=/opt/homebrew/opt/fzf
else
    " Fedora
    set rtp+=/usr/share/fzf
endif

" fzf
nnoremap <leader>ff :FZF<CR>
autocmd BufEnter * if &buftype != 'terminal' | set number relativenumber | endif

" Tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Terminal
if has('terminal')
  tnoremap <esc> <c-\><c-n>
  tnoremap <silent> <c-h> <c-\><c-n>:tmuxnavigateleft<cr>
  tnoremap <silent> <c-j> <c-\><c-n>:tmuxnavigatedown<cr>
  tnoremap <silent> <c-k> <c-\><c-n>:tmuxnavigateup<cr>
  tnoremap <silent> <c-l> <c-\><c-n>:tmuxnavigateright<cr>
  autocmd terminalopen * setlocal nonumber norelativenumber | startinsert
endif

let s:palette = [
    \ '#000000', '#5f8787', '#d0dfee', '#5f81a5',
    \ '#888888', '#999999', '#aaaaaa', '#c1c1c1',
    \ '#404040', '#5f8787', '#d0dfee', '#5f81a5',
    \ '#888888', '#999999', '#aaaaaa', '#c1c1c1'
    \ ]

for i in range(16)
    execute 'let g:terminal_color_' . i . ' = "' . s:palette[i] . '"'
endfor
