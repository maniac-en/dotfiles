-- toggle zenmode whilst turning off colorcolumn and line wrapping
vim.keymap.set(
    "n",
    "<leader>zz",
    function()
        require("zen-mode").toggle({
            window = {
              width = 0.85
            },
            on_open = function(win)
              vim.o.colorcolumn = "0"
            end,
            on_close = function()
              vim.o.colorcolumn = "80"
            end
        })
    end,
    { noremap = true, desc = 'Toggle Zen Mode' }
)
