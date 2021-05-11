" spell-under.vim -- a Vim plugin to force to use underline for spell check results
" copyright (C) 2019 Osamu Aoki <osamu@debian.org>
"
" vim: set sw=2 sts=2 et ft=vim :

if &cp || exists("g:loaded_spell_under") || v:version < 700
    finish
endif
let g:loaded_spell_under = 1

" Force to use underline for spell check results
augroup SpellUnderline
  autocmd!
  autocmd ColorScheme *
    \ highlight SpellBad
    \   cterm=Underline
    \   ctermfg=NONE
    \   ctermbg=NONE
    \   term=Reverse
    \   gui=Undercurl
    \   guisp=Red
  autocmd ColorScheme *
    \ highlight SpellCap
    \   cterm=Underline
    \   ctermfg=NONE
    \   ctermbg=NONE
    \   term=Reverse
    \   gui=Undercurl
    \   guisp=Red
  autocmd ColorScheme *
    \ highlight SpellLocal
    \   cterm=Underline
    \   ctermfg=NONE
    \   ctermbg=NONE
    \   term=Reverse
    \   gui=Undercurl
    \   guisp=Red
  autocmd ColorScheme *
    \ highlight SpellRare
    \   cterm=Underline
    \   ctermfg=NONE
    \   ctermbg=NONE
    \   term=Reverse
    \   gui=Undercurl
    \   guisp=Red
  augroup END

" Available color schemes in the baseline vim:
"   blue darkblue default delek desert elflord evening industry koehler
"   morning murphy pablo peachpuff ron shine slate torte zellner
let s:spell_under =  get(g:, 'spell_under', get(g:, 'colors_name', 'NONE'))
if s:spell_under !=# 'NONE'
  exec 'colorscheme ' . s:spell_under
endif

