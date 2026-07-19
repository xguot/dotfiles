" |Caps> <-> |Ctrl> ^ |Ctrl, [> = |Esc>

set nocompatible
filetype plugin indent on
syntax off

let mapleader = " "

set incsearch hlsearch ignorecase smartcase
set clipboard=unnamed mouse=a hidden
set updatetime=50
set nowrap guicursor=a:block formatoptions+=j
set tabstop=4 shiftwidth=4 expandtab smartindent
set wildmenu wildmode=full
set list listchars=tab:\ \ ,trail:␣

highlight SignColumn ctermbg=NONE guibg=NONE
highlight TrailingWhitespace ctermbg=blue

nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
nnoremap Y y$

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

augroup TrailingSpace
  autocmd!
  autocmd WinEnter,BufWinEnter * match TrailingWhitespace /\s\+$/
augroup END

augroup CustomSettings
  autocmd!
  autocmd FileType c,go setlocal ts=8 sw=8 noexpandtab
  autocmd FileType cpp setlocal ts=4 sw=4 expandtab
  autocmd FileType lua,ruby,javascript,typescript,svelte,r,vim setlocal ts=2 sw=2 expandtab
  autocmd FileType tex,latex,markdown,text setlocal wrap linebreak breakindent
augroup END

if isdirectory('/opt/homebrew/opt/fzf')
  set rtp+=/opt/homebrew/opt/fzf

  nnoremap <silent> <C-p> :Files<CR>
  nnoremap <silent> <Leader><Leader> :GFiles<CR>
  nnoremap <silent> <Leader>, :Buffers<CR>
  nnoremap <silent> <Leader>/ :RG<CR>

  imap <C-X><C-K> <plug>(fzf-complete-word)
  imap <C-X><C-F> <plug>(fzf-complete-path)
  imap <C-X><C-L> <plug>(fzf-complete-line)
endif
