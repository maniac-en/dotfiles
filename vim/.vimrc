""" enter the current millenium
set nocompatible

""" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
scriptencoding utf-8

""" spellcheck file
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

""" Disable BCE to use Ctrl/Shift + arrow keys working inside tmux when using vim
" https://sunaku.github.io/vim-256color-bce.html
" https://superuser.com/a/562437
" set t_ut=

""" appearance
set t_Co=256
set background=dark
colorscheme custom
if has('termguicolors')
	set termguicolors
endif
set laststatus=2
set ruler
set scrolloff=1 sidescrolloff=5
set number
set relativenumber
set splitbelow splitright
set noshowcmd
set shortmess=Iac
set hidden

""" misc
set listchars=tab:>-,space:@,eol:⏎
set backspace=indent,eol,start
set modeline
set autoindent smartindent noexpandtab
set undofile
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50
set dir=$HOME/.cache/vim
set undodir=$HOME/.cache/vim/undo
set autoread
set noerrorbells
set updatetime=300
set ttymouse=xterm2
set mouse=a
set dictionary+=/usr/share/dict/words
map Q gq

""" functions
fu! StatuslineTrailingSpaceWarning()
        if !exists('b:statusline_trailing_space_warning')
                if search('\s\+$', 'nw') != 0
                        let b:statusline_trailing_space_warning = '[ts]'
                else
                        let b:statusline_trailing_space_warning = ''
                endif
        endif
        return b:statusline_trailing_space_warning
endf

fu! ToggleStatusBar()
        if s:hidden_all  == 0
                let s:hidden_all = 1
                set noshowmode
                set noruler
                set laststatus=0
        else
                let s:hidden_all = 0
                set showmode
                set ruler
                set laststatus=2
        endif
endf

fu! s:find_git_root()
        return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endf

" Source: https://vi.stackexchange.com/a/5977 for cmdheight
fu! Buildnote()
        set cmdheight=2
        echom 'Building '.expand('%')
        set cmdheight=1
        silent! execute '!/home/maniac/scripts/system/buildNote.sh %:p'
        redraw!
endfu

""" status-line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{StatuslineTrailingSpaceWarning()}%=%(l:\%l,\ \c:%c,\ %P\ %)
augroup cal_white_space
        autocmd!
        autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
augroup end

" toggle statusbar
let s:hidden_all = 1
call ToggleStatusBar()

""" NERDcommentor
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check if all selected lines are commented or not
let g:NERDToggleCheckAllLines = 1

" NERD Custom Delimiters
let g:NERDCustomDelimiters = { 'vim': { 'left': '"', 'leftAlt': '"""' }, }

""" undotree
let g:undotree_WindowLayout = 2
let g:undotree_DiffAutoOpen = 0
let g:undotree_DiffpanelHeight = 10
let g:undotree_HighlightChangedText = 0
let g:undotree_HighlightChangedWithSign = 0
let g:undotree_SetFocusWhenToggle = 1

""" vim-instant-markdown
let g:instant_markdown_autostart = 0
let g:instant_markdown_browser = 'chromium --new-window'
let g:instant_markdown_port = 9999

""" fzf.vim
set rtp+=$HOME/.fzf
let g:fzf_layout = { 'down': '~40%' }

""" vim help tags
packloadall
silent! helptags ALL

""" search in git project else in current dir
command! -bang -nargs=* PRg
                        \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2], 'options': '--delimiter : --nth 4..'}, <bang>0)
command! ProjectFiles execute 'Files' s:find_git_root()

""" change default grep to rg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
let g:rg_derive_root='true'

""" to change cursorline when entering insert mode
augroup cursor_change
	autocmd InsertEnter * silent execute "!echo -en '\e[5 q'"
	autocmd InsertLeave * silent execute "!echo -en '\e[2 q'"
augroup END

""" search settings
set hlsearch
set history=10000
set incsearch
set ignorecase
set smartcase

""" netrw-settings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_altv = 1

""" tab-completion setting
set wildmenu
set wildmode=longest:full,full
set wildchar=<TAB>

""" file-format settings
set fileformats=unix,dos
syntax enable
filetype plugin indent on

" filetype auto-commands
augroup fileType
        autocmd!
        autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        autocmd filetype tags setlocal formatoptions+=c formatoptions+=r formatoptions+=o
        " uses https://github.com/jtratner/vim-flavored-markdown
        autocmd BufNewFile,BufRead *.md,*.markdown set filetype=ghmarkdown
        autocmd filetype sh nmap <leader>r :w<CR>:!clear;bash %<CR>
        autocmd filetype python nmap <leader>r :w<CR>:!clear;python %<CR>
	autocmd filetype c nmap <leader>r :w<CR>:!clear; gcc % && ./a.out<CR>
        autocmd BufRead,BufNewFile *.sage nmap <leader>r :w<CR>:!clear;sage %<CR>
augroup END

""" wrap settings
set linebreak nowrap

""" highlight trailing whitespaces
command! HighlightExtraSpaces :match Search /\S\zs\s\+$/

""" remove trailing whitespaces
command! RemoveExtraSpaces :%s/\s\+$//g

""" mappings
" remap leader-key
let mapleader = ','

" stop highlighting matches
nnoremap <silent> <Esc><Esc> :noh<CR>:match<CR>:redraw!<CR>

" netrw
nnoremap <silent> - :Vexplore<CR>

" status-bar
nnoremap <silent> <F7> :call ToggleStatusBar()<CR>

" undotree
nnoremap <silent> <F5> :UndotreeToggle<CR>

" fzf mappings
nnoremap <silent> <C-p> :w<CR>:ProjectFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <leader>f :w<CR>:PRg<CR>
nnoremap <silent> <leader>F :Filetypes<CR>
nnoremap <silent> \ :BLines<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" write & quit mapping
noremap <silent> <leader>x :x<CR>
noremap <silent> <leader>w :w<CR>
noremap <silent> <leader>q :q<CR>
noremap <silent> <leader>wq :wq<CR>
noremap <silent> <leader>a :qall<CR>
noremap <silent> <leader>Q :q!<CR>

" quick split
noremap <silent> <leader>vs :vsp<CR>
noremap <silent> <leader>hs :sp<CR>
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-l> <C-w>l

" tab to switch b/w parenthesis
noremap <silent> <TAB> %

" check file in shellcheck:
nmap <silent> <leader>s :w<CR>:!clear && shellcheck -x %<CR>

" closing a buffer
noremap <silent> <leader>d :bd<CR>

" subsitute map
map <leader>S :%s///g<Left><Left><Left>

" easy movement around wrapped lines
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$
noremap <Up> g<Up>
noremap <Down> g<Down>

" vim terminal
noremap <silent> <leader>t :botright vert term<CR>

" perform dot commands over visual selections
vnoremap . :normal .<CR>

" copy to primary clipboard
vnoremap <C-y> "+y

" config files
nnoremap <silent> <leader>ez :tabe $HOME/.zshrc<CR>
nnoremap <silent> <leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <leader>ea :tabe $HOME/.config/alacritty/alacritty.yml<CR>
augroup autosource_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC :source %
augroup END

" " auto-build notes
" augroup notes
"         autocmd!
"         autocmd BufWritePost *note-*.md call Buildnote()
" augroup END

""" even strager doesn't know why
set exrc secure
