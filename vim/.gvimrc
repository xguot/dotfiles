syntax on
set guifont=JetBrainsMono\ Nerd\ Font:h14
set guicursor+=a:blinkon0

" UI
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Visuals
autocmd GUIEnter * highlight! link SignColumn Normal
autocmd GUIEnter * highlight! link FoldColumn Normal
autocmd GUIEnter * highlight LineNr guibg=NONE guifg=#666666
autocmd GUIEnter * highlight CursorLineNr guibg=NONE guifg=#aaaaaa

if argc() == 0
    cd ~
endif
