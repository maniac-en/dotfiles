--[[
-- Inspired from:
-- 1. Tj (https://github.com/nvim-lua/kickstart.nvim/)
-- 2. ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
--]]

require("maniac")

-- @@@ experimenting
-- it's good to have guibg as None for WinSeparator/VertSplit highlight groups
-- for good looking statuslines in splits
vim.o.laststatus = 3 -- show global statusline
vim.o.winbar = "%=%m %f"
vim.o.stl = "%=%m %F %=%l/%L:%v"
