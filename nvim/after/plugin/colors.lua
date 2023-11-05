require("catppuccin").setup({
  color_overrides = {
    mocha = {
      base = "#020403",
      crust = "#666666",
    }
  }
})

vim.cmd.colorscheme "catppuccin-mocha"

local statusline_color = "guifg=#adadad guibg=#1b1b1b"
vim.cmd.highlight({ "StatusLine", statusline_color })
vim.cmd.highlight({ "StatusLineNC", statusline_color })

local line_column_color = "guibg=#181818"
vim.cmd.highlight({ "ColorColumn", line_column_color })
vim.cmd.highlight({ "CursorLine", line_column_color })
