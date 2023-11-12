-- open git logs in vim
vim.keymap.set('n', '<leader>gl', ':GV<CR>',
  { remap = false, silent = true, desc = 'MANIAC_GV [<leader>gl] Open [G]it [L]ogs commit browser' })
