setlocal iskeyword+=$
setlocal conceallevel=1
nnoremap <F2> :w<CR>:!clear;node %<CR>
inoremap <F2> <ESC>:w<CR>:!clear;node %<CR>
