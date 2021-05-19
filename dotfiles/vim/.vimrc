""" leader key
let mapleader=','

""" encoding n stuff
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp

""" spellcheck
set spellcapcheck=
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

""" general
set nocompatible
set t_Co=256
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
if has('termguicolors')
    set termguicolors
endif
set hidden " hide abandoned buffers rather than unloading
let g:loaded_matchparen = v:true
set modeline
set timeout timeoutlen=1000 ttimeoutlen=50
set dir=$HOME/.cache/vim
set undodir=$HOME/.cache/vim/undo
set undofile
set autoread
set noerrorbells
set updatetime=300
set dictionary+=/usr/share/dict/words
set concealcursor=nv

""" whitespace, indention, etc.
set sw=4 et
set softtabstop=-1
set ts=8
set nosmartindent
set cin noai
set tw=80

""" wrap settings
set linebreak nowrap
set nojoinspaces

""" text manipulation
set bs=indent,eol,start
set completeopt=menu,preview

""" use mouse to manage splits
set ttyfast
set mouse=a
set ttymouse=sgr

""" navigation
set nofoldenable
set foldmethod=marker
set relativenumber
set numberwidth=3
set nostartofline

""" sane searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <silent> <Leader>l :noh<CR>

""" Windows management
nmap <silent> th <C-W>h
nmap <silent> tl <C-W>l
nmap <silent> tj <C-W>j
nmap <silent> tk <C-W>k
nmap <silent> ts :split<SPACE>
nmap <silent> tv :vsplit<SPACE>
nmap <silent> tc <C-W>c
set splitbelow splitright

""" tabs management
" use <Leader>c to pop the tab stack
nmap <silent> <Leader>c :tabclose<CR>
" <leader><num> to get to a tab<num>
let s:i = 1
while s:i <= 10
    execute printf('nnoremap <silent> <Leader>%d :%dtabnext<CR>', s:i == 10 ? 0 : s:i, s:i,)
    let s:i += 1
endwhile

""" easy movement around wrapped lines
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> <Up> g<Up>
noremap <silent> <Down> g<Down>

""" vselect and gist the selection
command -range GistLines call system('gist', getbufline('%', <line1>, <line2>))
vnoremap <F2> :GistLines<CR>

""" handle <ESC> immediately in insert mode. Wait indefinitely for incomplete mappings.
set esckeys
set notimeout ttimeout ttimeoutlen=0

" help cmd
cnoreabbrev <expr> help getcmdtype() == ":" && getcmdline() == 'help' ? 'tab help' : 'help'
nnoremap <leader>h :tab help<space>

""" terminal
set title
set titlestring=%t
set titleold=
" Treat undercurl as underline in terminal
set t_Cs= t_Ce=

""" command line
set wildmenu
set wildmode=longest,full
set wildchar=<TAB>

""" save history
set history=10000
set viminfo+=/200
set viminfo+=:10000

""" syntax hilighting
syntax on
filetype on
filetype indent on
filetype plugin on

""" display
set cursorline
set number
set relativenumber
set noshowcmd
set nowrap
set ruler
set laststatus=2
set list
set listchars=
set listchars+=tab:⇥\ ,precedes:<,extends:>
set sidescroll=5
set scrolloff=5
set shortmess=a     " Abbreviate status line
set shortmess+=tToO " Other crap

""" ripgrep (rg)
let g:rg_command='rg --vimgrep --smart-case --follow'
let g:rg_derive_root='true'

""" to change cursorline when entering insert mode
augroup cursor_change
    autocmd InsertEnter * silent execute "!echo -en '\e[5 q'"
    autocmd InsertLeave * silent execute "!echo -en '\e[2 q'"
augroup END

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

fu! MD2PDF()
    set cmdheight=2
    echom 'Building '.expand('%')
    set cmdheight=1
    silent! execute '!markdown2pdf %:p'
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
nnoremap <silent> <F7> :call ToggleStatusBar()<CR>

""" highlight trailing whitespaces
command! HighlightExtraSpaces :match Search /\S\zs\s\+$/

""" remove trailing whitespaces
command! RemoveExtraSpaces :%s/\s\+$//ge | nohl

""" LOAD'em PLUGINS
""" load all plugins
packloadall

""" gen all helptags
silent! helptags ALL

""" vim-vinegar(https://github.com/tpope/vim-vinegar)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

""" fzf.vim (https://github.com/junegunn/fzf.vim)
set rtp+=$HOME/.fzf
let g:fzf_layout = {'down': '~40%'}
let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
" search in git project else in current dir
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
command! -bang -nargs=* Search call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2], 'options': '--delimiter : --nth 4..'}, <bang>0)
command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <silent> <C-p> :w<CR>:ProjectFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <leader>f :w<CR>:Search<CR>
nnoremap <silent> <leader>F :Filetypes<CR>
nnoremap <silent> \ :BLines<CR>

""" nerdcommentor (https://github.com/preservim/nerdcommenter)
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

""" undotree (https://github.com/mbbill/undotree.git)
let g:undotree_WindowLayout = 2
let g:undotree_DiffAutoOpen = 0
let g:undotree_DiffpanelHeight = 10
let g:undotree_HighlightChangedText = 0
let g:undotree_HighlightChangedWithSign = 0
let g:undotree_SetFocusWhenToggle = 1
nnoremap <silent> <F5> :UndotreeToggle<CR>

""" my custom shortcuts
" save, quit, etc.
noremap <silent> <leader>q :qa<CR>
nnoremap <silent> <leader>d :q<CR>
noremap <silent> <leader>wa :wa<CR>
noremap <silent> <leader>wq :x<CR>
noremap <silent> <leader>x :x<CR>
noremap <silent> <leader>Q :q!<CR>
" tab to jump parenthesis
noremap <silent> <SPACE> %
" subsitute map
nnoremap <leader>r :%s///g<Left><Left><Left>
" delete map
nnoremap <leader>R :%g//d<Left><Left>
" copy to primary clipboard
vnoremap <silent> <C-y> "+y
" autocd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" open vimrc in new tab
nnoremap <silent> <leader>ev :tabe $MYVIMRC<CR>
" sorting made easy
nmap <silent> <Leader>s vip:sort u<CR>
vmap <silent> <Leader>s :sort u<CR>
nmap <silent> <Leader>S vip:sort iu<CR>
vmap <silent> <Leader>S :sort iu<CR>
" make Y consistent with D (i.e. D : d$ :: Y : y$)
nnoremap <silent> Y y$
" navigate jump list with \j, \k
nnoremap <silent> <Leader>j <C-I>
nnoremap <silent> <Leader>k <C-O>

" custom augroups
augroup generic_fileoptions
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
augroup autosource_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC :source %
augroup END
augroup wrapped_fileoptions
    autocmd!
    autocmd filetype gitcommit setlocal cc=72
    autocmd filetype md setlocal cc=80 formatoptions+=t
    autocmd filetype text setlocal cc=80 formatoptions+=t
    autocmd BufWritePost *note-*.md call MD2PDF()
augroup END
augroup python_file_type
    autocmd!
    autocmd filetype python nnoremap <F2> :w<CR>:!clear;python %<CR>
    autocmd filetype python inoremap <F2> :w<CR>:!clear;python %<CR>
augroup END
augroup sh_file_type
    autocmd!
    autocmd filetype sh nnoremap <silent> <F1> :w<CR>:!clear; shellcheck -x %:p<CR>
    autocmd filetype sh nnoremap <F2> :w<CR>:!clear;bash %<CR>
    autocmd filetype sh inoremap <F2> :w<CR>:!clear;bash %<CR>
augroup END
augroup notes_to_pdf
    autocmd!
    autocmd BufWritePost *note-*.md call Buildnote()
augroup END