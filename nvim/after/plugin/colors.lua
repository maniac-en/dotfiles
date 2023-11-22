---@diagnostic disable-next-line: missing-fields
-- require("tokyonight").setup({
--   style = "night",
--   sidebars = { "qf", "vista_kind", "terminal", "packer" },
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   on_colors = function(colors)
--     colors.hint = colors.orange
--     colors.error = "#ff0000"
--   end,
--
--   on_highlights = function(highlights, _)
--     highlights.StatusLine = { fg = "#a9b1d6", bg = "#22222e" }
--     highlights.StatusLineNC = highlights.statusline
--     highlights.ColorColumn = { bg = "#272736" }
--     highlights.ManiacTodo = { fg = "#e0af68" }
--   end
-- })
--
-- vim.cmd.colorscheme "tokyonight-night"
--
require("gruvbox").setup({
  overrides = {
    SignColumn = {bg = "#292929"},
    StatusLine = {fg = "#303030"},
    StatusLineNC = {fg = "#303030"},
    CursorLine = {bg = "#303030"},
    CursorLineNr = {bg = "#303030"},
    ColorColumn = {bg = "#303030"},
    LineNr = {bg = "#282828"},
    WinBar = {fg = "#ffffff", bg=""},
    WinBarNC = {fg = "#ffffff", bg=""},
    debugPC = {bg="#505050"},
  }
})

vim.cmd.colorscheme "gruvbox"

-- case-insensitive match TODO, FIXME, @@@
vim.fn.matchadd("GruvboxYellowBold", [[\v\c<TODO>]])
vim.fn.matchadd("GruvboxYellowBold", [[\v\c<FIXME>]])
vim.fn.matchadd("GruvboxYellowBold", [[@@@]])
