" |Caps> <-> |Ctrl> ^ |Ctrl, [> = |Esc>

" Core
set nocompatible
filetype plugin indent on
let mapleader = " "
set clipboard=unnamed mouse=a hidden nowrap
set number scrolloff=8
set updatetime=50 guicursor=a:block formatoptions+=j
set tabstop=4 shiftwidth=4 expandtab smartindent
set wildmenu wildmode=full

" Visuals
syntax off
set list listchars=tab:\ \ ,trail:␣
highlight SignColumn ctermbg=NONE guibg=NONE
highlight TrailingWhitespace ctermbg=blue

augroup TrailingSpace
  autocmd!
  autocmd WinEnter,BufWinEnter * match TrailingWhitespace /\s\+$/
augroup END

" Search & Nav
set incsearch hlsearch ignorecase smartcase
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Filetypes
augroup CustomSettings
  autocmd!
  autocmd FileType c,go setlocal ts=8 sw=8 noexpandtab
  autocmd FileType cpp setlocal ts=4 sw=4 expandtab
  autocmd FileType lua,ruby,javascript,typescript,svelte,r,vim setlocal ts=2 sw=2 expandtab
  autocmd FileType tex,latex,markdown,text setlocal wrap linebreak breakindent spell spelllang=en_us
  if has('terminal')
    autocmd TerminalWinOpen * setlocal nonumber norelativenumber | startinsert
  endif
  autocmd BufEnter * if &buftype == '' | setlocal number | endif
augroup END

" fzf Integration
if isdirectory('/opt/homebrew/opt/fzf') | set rtp+=/opt/homebrew/opt/fzf | endif
nnoremap <C-p> :Files<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
