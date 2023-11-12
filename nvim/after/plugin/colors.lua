---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
  style = "night",
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,

  on_highlights = function(highlights, _)
    highlights.StatusLine = { fg = "#a9b1d6", bg = "#22222e" }
    highlights.StatusLineNC = highlights.statusline
    highlights.ColorColumn = { bg = "#272736" }
    highlights.ManiacTodo = { fg = "#e0af68" }
  end
})

vim.cmd.colorscheme "tokyonight-night"

-- case-insensitive match TODO, FIXME, @@@
vim.fn.matchadd("ManiacTodo", [[\v\c<TODO>]])
vim.fn.matchadd("ManiacTodo", [[\v\c<FIXME>]])
vim.fn.matchadd("ManiacTodo", [[@@@]])
