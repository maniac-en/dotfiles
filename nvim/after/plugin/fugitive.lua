local map = function(mode, lhs, rhs, desc, silent)
  silent = silent or false
  if desc then
    desc = "MANIAC_FUGITIVE: " .. desc
  end
  vim.keymap.set(mode, lhs, rhs, { remap = false, silent = silent, desc = desc })
end

map("n", "<leader>gs", vim.cmd.Git, "[<leader>gs] [G]it [S]tatus", true)
map("n", "<leader>gd", ":Gvdiffsplit<SPACE>", "[<leader>gd] Populate with :Gvdiffsplit ; Like [G]it [D]iff", false)
map("n", "<leader>gb", ":GBrowse % @", "[<leader>gb] Open current [G]it file in [B]rowser", false)
map("n", "<leader>gw", ":Gwrite<CR>", "[<leader>gw] [G]it [W]rite to work tree and index", false)
map("n", "<leader>gc", ":G commit -S -vv <CR>", "[<leader>gc] [G]it signed [C]ommit with verbose and diff", false)
map("n", "<leader>gp", ":G push<SPACE>", "[<leader>gp] Populate with :G push ; Like [G]it [P]ush", false)
