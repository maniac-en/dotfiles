-- git status
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { noremap = true, silent = true })
-- populate with :Gvdiffsplit
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<SPACE>', { noremap = true })
-- open current git file in browser
-- for github -> https://github.com/tpope/vim-rhubarb
-- vim.keymap.set('n', '<leader>gb', ':GBrowse<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gb', ':GBrowse % @', { noremap = true })
-- write to git work tree and index versions of the file
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { noremap = true })
-- git signed verbose commit with unified diff
vim.keymap.set('n', '<leader>gc', ':G commit -S -vv <CR>', { noremap = true })
-- populate with :G push
vim.keymap.set('n', '<leader>gp', ':G push<SPACE>', { noremap = true })
