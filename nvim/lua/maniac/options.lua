-- line numbers, noremal and relative
vim.o.number = true
vim.o.relativenumber = true

-- sane searching
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- swap file directory
vim.o.directory = vim.fn.expand("$HOME") .. "/.cache/nvim"

-- Save undo history
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("$HOME") .. "/.cache/nvim/undo"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- enable signcolumn by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Open splits to below or right
vim.o.splitbelow = true
vim.o.splitright = true

-- encoding n stuff
vim.o.encoding = "utf-8"
vim.o.fileencodings = "utf-8,iso-2022-jp,sjis,euc-jp"

-- backspace over auto indents, line breaks, insert start
vim.o.backspace = "indent,eol,start"

-- disable first word capitalization spellchecks
vim.o.spellcapcheck = ""

-- spellcheck language
vim.o.spelllang = "en"

-- wordlist for spellchecking
vim.o.spellfile = vim.fn.expand("$HOME") .. "/.config/nvim/spell/en.utf-8.add"

-- enable cursorline
vim.o.cursorline = true

-- enable colorcolumn
vim.o.colorcolumn = "80"

-- move cursor to 1st non-blank while navigation
vim.o.startofline = true

-- encoding n stuff
vim.o.encoding = "utf-8"
vim.o.fileencodings = "utf-8,iso-2022-jp,sjis,euc-jp"

-- backspace over auto indents, line breaks, insert start
vim.o.backspace = "indent,eol,start"

-- disable first word capitalization spellchecks
vim.o.spellcapcheck = ""

-- spellcheck language
vim.o.spelllang = "en"

-- wordlist for spellchecking
vim.o.spellfile = vim.fn.expand("$HOME") .. "/.config/nvim/spell/en.utf-8.add"

-- enable cursorline
vim.o.cursorline = true

-- enable colorcolumn
vim.o.colorcolumn = "80"

-- move cursor to 1st non-blank while navigation
vim.o.startofline = true

-- text/comments breaking/wrapping
-- @@@ check if 'formatoptions' really needed to be put in autocommands
-- @@@ further-check by disabling if the defaults provided by ftplugins are good
-- or not
-- vim.o.formatoptions = "cqroj"
vim.o.linebreak = true
vim.o.textwidth = 80
vim.o.wrap = true

-- shortmess stuff
vim.o.shortmess = "atToO"

-- scrolling
vim.o.sidescroll = 8
vim.o.scrolloff = 8

-- listchars
vim.o.listchars = "tab:»·,space:.,trail:·"

-- show as much as possible of last line
vim.o.display = "lastline,uhex"

-- always report changed lines
vim.o.report = 0

-- disable cursor position
vim.o.ruler = false

-- script encoding
vim.api.nvim_set_var('scriptencoding', "utf-8")

-- turn on syntax highlighting
vim.api.nvim_set_var('syntax', 'on')

-- colors
vim.api.nvim_set_var('t_co', 256)
vim.api.nvim_set_var('background', 'dark')
