require("tokyonight").setup({
  style = "night",
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,
})

vim.cmd.colorscheme "tokyonight-night"

local statusline_color = "guifg=#a9b1d6 guibg=#22222e"
vim.cmd.highlight({ "StatusLine", statusline_color })
vim.cmd.highlight({ "StatusLineNC", statusline_color })
vim.cmd.highlight({ "ColorColumn",  "guibg=#272736" })
