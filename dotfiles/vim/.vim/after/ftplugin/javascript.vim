setlocal iskeyword+=$
setlocal shiftwidth=2
setlocal conceallevel=1
nnoremap <F2> :w<CR>:!clear;node %<CR>
inoremap <F2> <ESC>:w<CR>:!clear;node %<CR>
