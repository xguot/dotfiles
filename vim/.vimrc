" General
syntax on
set encoding=utf-8
set mouse=a
set number relativenumber

" Search
set hlsearch ignorecase smartcase

" Indentation 
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent

" Wrapping
set wrap linebreak showbreak=...

" Languages 
autocmd FileType ruby   setlocal ts=2 sw=2 sts=2 et
autocmd FileType python setlocal ts=4 sw=4 sts=4 et colorcolumn=88
let g:python_highlight_all = 1

" Colors
colorscheme zaibatsu
