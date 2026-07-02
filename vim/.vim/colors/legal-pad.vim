" Name:         legal-pad
" Description:  A mathematically optimized, perfectly isoluminant analog workspace.
" Maintainer:   Tuned for a purist, monochrome-first workflow.

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'legal-pad'
set background=light

" Core editor colors (CIELAB calculated graphite ink on transparent bg)
hi Normal guibg=NONE ctermbg=NONE guifg=#66737C ctermfg=NONE
hi StatusLine guibg=NONE ctermbg=NONE guifg=#66737C ctermfg=0 gui=NONE cterm=NONE

" Semantic palette definitions
hi PaletteActiveFocus  guibg=#6CBDF5 ctermbg=117 guifg=#000000 ctermfg=0 gui=bold
hi PalettePassiveMatch guibg=#D4E6F8 ctermbg=153 guifg=#000000 ctermfg=0 gui=NONE
hi PaletteMutedUI      guibg=NONE    ctermbg=NONE guifg=#7F8C94 ctermfg=8 gui=NONE

" Muted structural UI
hi! link NonText      PaletteMutedUI
hi! link EndOfBuffer  PaletteMutedUI
hi! link CursorLine   PaletteMutedUI
hi! link CursorLineNr PaletteMutedUI
hi! link SignColumn   PaletteMutedUI
hi! link FoldColumn   PaletteMutedUI
hi! link LineNr       PaletteMutedUI
hi! link StatusLineNC PaletteMutedUI
hi! link VertSplit    PaletteMutedUI
hi! link WinSeparator PaletteMutedUI
hi! link Comment      PaletteMutedUI
hi! link Conceal      PaletteMutedUI

" Active focus states
hi! link IncSearch  PaletteActiveFocus
hi! link CurSearch  PaletteActiveFocus
hi! link MatchParen PaletteActiveFocus
hi! link WildMenu   PaletteActiveFocus
hi! link PmenuSel   PaletteActiveFocus
hi! link Question   PaletteActiveFocus
hi! link MoreMsg    PaletteActiveFocus

" Passive selection and matches
hi! link Search       PalettePassiveMatch
hi! link Visual       PalettePassiveMatch
hi! link Pmenu        PalettePassiveMatch
hi! link QuickFixLine PalettePassiveMatch
hi! link ColorColumn  PalettePassiveMatch

" Tame the Spell checker
hi SpellBad guibg=NONE ctermbg=NONE guifg=NONE gui=undercurl guisp=#BA5E5A cterm=underline
hi SpellCap guibg=NONE ctermbg=NONE guifg=NONE gui=undercurl guisp=#59779E cterm=underline
hi SpellRare guibg=NONE ctermbg=NONE guifg=NONE gui=undercurl guisp=#926388 cterm=underline
hi SpellLocal guibg=NONE ctermbg=NONE guifg=NONE gui=undercurl guisp=#5C7E5A cterm=underline

" Force monochrome text even if syntax highlighting is accidentally triggered
hi! link Constant Normal
hi! link String Normal
hi! link Character Normal
hi! link Number Normal
hi! link Boolean Normal
hi! link Float Normal
hi! link Identifier Normal
hi! link Function Normal
hi! link Statement Normal
hi! link Conditional Normal
hi! link Repeat Normal
hi! link Label Normal
hi! link Operator Normal
hi! link Keyword Normal
hi! link Exception Normal
hi! link PreProc Normal
hi! link Include Normal
hi! link Define Normal
hi! link Macro Normal
hi! link PreCondit Normal
hi! link Type Normal
hi! link StorageClass Normal
hi! link Structure Normal
hi! link Typedef Normal
hi! link Special Normal
hi! link SpecialChar Normal
hi! link Tag Normal
hi! link Delimiter Normal
hi! link SpecialComment Normal
hi! link Debug Normal
