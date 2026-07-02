" Core settings
set nocompatible
set t_ut=

" HPC/SSH latency fixes
if !empty($SSH_CONNECTION)
    " Prevent older Vim crashes
    silent! set t_u7=
    silent! set t_RV=
    silent! set t_RS=
    silent! set t_RB=
    silent! set t_RF=
endif

filetype plugin indent on
let mapleader = " "
set mouse=a
set number relativenumber
set scrolloff=8
set termguicolors
set signcolumn=yes
set guicursor=a:block
set updatetime=50
set hidden
set formatoptions=j
set nowrap

" Indentation rules
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab smartindent

" Homebrew fzf path fix
if isdirectory('/opt/homebrew/opt/fzf')
    set rtp+=/opt/homebrew/opt/fzf
endif

" HPC vs Local clipboard
if !empty($SSH_CONNECTION)
    set clipboard=
    set statusline=%F\ [HPC]\ %m%r%h\ %w\ \ C:%c\ L:%l/%L
else
    set clipboard=unnamed
endif

" Force TrueColor over SSH
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Base appearance
syntax off
colorscheme legal-pad

" Search behavior
set incsearch
set hlsearch
set ignorecase
set smartcase

" Navigation and splits
nnoremap - :e %:h<CR>
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Editing macros
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap J mzJ`z
vnoremap < <gv
vnoremap > >gv

" fzf keybindings
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>sp :Fg<space>
nnoremap <leader>sm :Marks<CR>
nnoremap <leader>gl :Commits<CR>
nnoremap <leader>gc :BCommits<CR>

" fzf grep logic
command! -bang -nargs=* Fg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'window': 'full'}), 1)

" Filetype specific logic
augroup CustomSettings
  autocmd!
  autocmd FileType c,go setlocal ts=8 sw=8 sts=0 noexpandtab
  autocmd FileType cpp setlocal ts=4 sw=4 sts=4 expandtab
  autocmd FileType lua,ruby,javascript,typescript,svelte,r,vim setlocal ts=2 sw=2 sts=2 expandtab
  autocmd FileType tex,latex,markdown,text setlocal wrap linebreak breakindent spell spelllang=en_us
  if has('terminal')
    if exists('##TerminalWinOpen')
      autocmd TerminalWinOpen * setlocal nonumber norelativenumber | startinsert
    else
      autocmd TerminalOpen * setlocal nonumber norelativenumber | startinsert
    endif
  endif
augroup END
