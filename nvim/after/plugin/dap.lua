require("nvim-dap-virtual-text").setup({
   virt_text_pos = 'eol'
})
require("dapui").setup({
   layouts = {
      {
         elements = {
            { id = "watches", size = 0.65 },
            { id = "repl",    size = 0.35 },
         },
         position = "bottom",
         size = 12
      },
      {
         elements = {
            { id = "scopes", size = 0.5 },
            { id = "stacks", size = 0.5 },
         },
         position = "left",
         size = 40
      },
   },
})
--
local dap = require("dap")
local dapui = require("dapui")

-- debugger mappings
vim.keymap.set("n", "<F1>", function() dap.step_into() end, { noremap = true })
vim.keymap.set("n", "<F2>", function() dap.step_over() end, { noremap = true })
vim.keymap.set("n", "<F3>", function() dap.step_out() end, { noremap = true })
vim.keymap.set("n", "<F4>", function() dapui.toggle() end, { noremap = true })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { noremap = true })

vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { noremap = true })
vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end,
   { noremap = true })
vim.keymap.set("n", "<leader>dr", function() dapui.open({ reset = true }) end, { noremap = true })

-- remove colorcolumn from dap buffers
local ManiacDapUI = vim.api.nvim_create_augroup("ManiacDapUI", { clear = true })
vim.api.nvim_create_autocmd("FileType",
   {
      group = ManiacDapUI,
      pattern = "dap*",
      callback = function(opts)
         vim.api.nvim_create_autocmd({ "BufWinEnter", "BufLeave" },
            {
               buffer = opts.buf,
               callback = function() vim.opt.colorcolumn = "0" end
            })
      end,
   })
