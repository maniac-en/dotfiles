" HACK(maniac)
" let g:prior = maparg("<CR>", "n")
" nmap <silent> <buffer> <CR> <Plug>NetrwLocalBrowseCheck:let b:ale_enabled = 0<CR>

" HACK(D. Ben Knoble)
" suggested in comments: https://vi.stackexchange.com/a/31503/29810
" execute 'nmap <silent> <buffer> <CR>' maparg('<CR>', 'n').':let b:ale_enabled = 0<CR>'
