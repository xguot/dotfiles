" Meta
autocmd BufWritePost .vimrc source %
set nocompatible            " unlocking the good stuff
let mapleader = " "

" General
set encoding=utf-8
set mouse=a
set number relativenumber

" File navigation
nnoremap - :Explore<CR>    
let g:netrw_liststyle = 0  " thin view is more stable in standard Vim
let g:netrw_banner = 0     " keeps it clean

" Search
set hlsearch ignorecase smartcase
nnoremap <silent> <C-[> :nohlsearch<CR>

" System clipboard
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>p "+p
vnoremap <Space>p "+p

" Indentation 
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent

" Wrapping
set wrap linebreak showbreak=...

" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split windows
nnoremap <leader>\| :vsplit<CR>
nnoremap <leader>- :split<CR>

" Resize windows with Space + hjkl (10 units)
nnoremap <leader>h :vertical resize -10<CR>
nnoremap <leader>l :vertical resize +10<CR>
nnoremap <leader>k :resize -10<CR>
nnoremap <leader>j :resize +10<CR>

" Languages 
autocmd FileType ruby   setlocal ts=2 sw=2 sts=2 et
autocmd FileType python setlocal ts=4 sw=4 sts=4 et colorcolumn=0
let g:python_highlight_all = 1

function! TmuxMove(direction)
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the window number didn't change, we are at the edge; tell tmux to move
    if wnr == winnr()
        call system('tmux select-pane -' . tr(a:direction, 'hjkl', 'LDUR'))
    endif
endfunction

" Navigation (Normal Mode)
nnoremap <silent> <C-h> :call TmuxMove('h')<CR>
nnoremap <silent> <C-j> :call TmuxMove('j')<CR>
nnoremap <silent> <C-k> :call TmuxMove('k')<CR>
nnoremap <silent> <C-l> :call TmuxMove('l')<CR>

" Terminal
if has('terminal')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <silent> <C-h> <C-\><C-n>:call TmuxMove('h')<CR>
  tnoremap <silent> <C-j> <C-\><C-n>:call TmuxMove('j')<CR>
  tnoremap <silent> <C-k> <C-\><C-n>:call TmuxMove('k')<CR>
  tnoremap <silent> <C-l> <C-\><C-n>:call TmuxMove('l')<CR>
  autocmd TerminalOpen * setlocal nonumber norelativenumber | startinsert
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

" Syntax highlighting is juvenile.
syntax off
set t_Co=256
set termguicolors
set background=dark

hi Normal       ctermbg=Black guibg=#000000
hi NonText      ctermbg=Black guibg=#000000
hi SignColumn   ctermbg=Black guibg=#000000
hi EndOfBuffer  ctermbg=Black guibg=#000000
hi LineNr       ctermfg=White guifg=#FFFFFF
hi CursorLineNr ctermfg=White guifg=#FFFFFF gui=bold
hi Search   ctermfg=Black ctermbg=White guifg=#000000 guibg=#FFFFFF
hi IncSearch ctermfg=Black ctermbg=White guifg=#000000 guibg=#FFFFFF
