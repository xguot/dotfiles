" |Caps> <-> |Ctrl> ^ |Ctrl, [> = |Esc>

" Core
filetype plugin indent on
let mapleader = " "
set clipboard=unnamed mouse=a hidden nowrap
set number relativenumber scrolloff=8 signcolumn=yes
set updatetime=50 guicursor=a:block formatoptions+=j
set tabstop=4 shiftwidth=4 expandtab smartindent

" Visuals
syntax off
highlight LineNr ctermfg=8 
highlight SignColumn ctermbg=NONE guibg=NONE

" fzf path
if isdirectory('/opt/homebrew/opt/fzf') | set rtp+=/opt/homebrew/opt/fzf | endif

" Search & Nav
set incsearch hlsearch ignorecase smartcase
nnoremap <leader>o- :e %:h<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" fzf bindings
nnoremap <leader>. :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>, :Buffers<CR>
nnoremap <leader>/ :Rg<space>
nnoremap <leader>sm :Marks<CR>
nnoremap <leader>gL :BCommits<CR>

" Filetypes
augroup CustomSettings
  autocmd!
  autocmd FileType c,go setlocal ts=8 sw=8 noexpandtab
  autocmd FileType cpp setlocal ts=4 sw=4 expandtab
  autocmd FileType lua,ruby,javascript,typescript,svelte,r,vim setlocal ts=2 sw=2 expandtab
  autocmd FileType tex,latex,markdown,text setlocal wrap linebreak breakindent spell spelllang=en_us
  if has('terminal')
    autocmd TerminalOpen,TerminalWinOpen * setlocal nonumber norelativenumber | startinsert
  endif
  autocmd BufEnter * if &buftype == '' | setlocal number relativenumber | endif
augroup END
