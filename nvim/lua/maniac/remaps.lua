-- Set the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- disable not-needed maps
vim.keymap.set('x', '<Space>', '<Nop>', { silent = true })
for _, m in ipairs({ "Q", "<left>", "<right>", "<up>", "<down>" }) do
  vim.keymap.set('n', m, '<Nop>')
end

-- stay in middle when jumping around, even while searching
vim.keymap.set('n', '<c-o>', '<c-o>zz', { noremap = true })
vim.keymap.set('n', '<TAB>', '<TAB>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

-- opening new splits/tabs
vim.keymap.set('n', 'ts', ':split<SPACE>', { noremap = true })
vim.keymap.set('n', 'tv', ':vsplit<SPACE>', { noremap = true })
vim.keymap.set('n', 'tn', ':tabe<SPACE>', { noremap = true })
vim.keymap.set('n', 'tc', ':tabclose<CR>', { noremap = true, silent = true })

-- Jump to normal mode using <ESC> in terminal
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

-- Stop highlighting text with <SPACE>
vim.keymap.set('n', '<SPACE>', ':noh<BAR>:echo<CR>', { noremap = true })

-- jump between matching pairs using backspace
vim.keymap.set('n', '<BS>', '%', { noremap = true, silent = true })

-- cd to buffer's present working directory
-- usually needed when I launch a file/folder in vim buffer not from a
-- project's folder
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { noremap = true })

-- show trailing whitespaces
vim.keymap.set('n', '<leader>ts', '/\\v\\s+$<CR>', { noremap = true, silent = true })

-- write/quit file conveniently
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<leader>x', ':x<CR>', { noremap = true })

-- tab open vim config
vim.keymap.set('n', '<leader>ev', ':tabedit ' .. vim.fn.expand("$HOME") .. '/.config/nvim<CR>',
  { noremap = true, silent = true })

-- Retain cursor position whilst joining lines
vim.keymap.set("n", "J", "mzJ`z", { noremap = true })

-- sudo write mapping
vim.keymap.set("s", "w!!", "w !sudo tee > /dev/null %")

-- retain yanked content whilst pasting in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true })

-- copy to system clipboard
vim.keymap.set('x', '<C-y>', '"+y', { noremap = true, silent = true })

-- Remap for dealing with word wrap
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '0', "v:count == 0 ? 'g0' : '0'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '$', "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })

-- sort selection
vim.keymap.set('x', '<leader>s', ':sort u<CR>', { noremap = true, silent = true })

-- move selected lines up/down
vim.keymap.set('x', "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('x', "K", ":m '<-2<CR>gv=gv", { noremap = true })
