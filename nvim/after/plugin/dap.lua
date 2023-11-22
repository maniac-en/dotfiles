local map = function(mode, lhs, rhs, desc)
   if desc then
      desc = "MANIAC_DAP: " .. desc
   end
   vim.keymap.set(mode, lhs, rhs, { remap = false, desc = desc })
end

require("nvim-dap-virtual-text").setup({
   virt_text_pos = 'eol'
})

---@diagnostic disable-next-line: missing-fields
require("dapui").setup({
   layouts = {
      {
         elements = {
            { id = "repl",    size = 1 },
         },
         position = "right",
         size = 75
      },
      {
         elements = {
            { id = "watches", size = 1 },
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
map("n", "<F1>", function() dap.step_into() end, "[<F1>] Debug Step Into")
map("n", "<F2>", function() dap.step_over() end, "[<F2>] Debug Step Over")
map("n", "<F3>", function() dap.step_out() end, "[<F3>] Debug Step Out")
map("n", "<F4>", function() dapui.toggle() end, "[<F4>] Debug UI Toggle")
map("n", "<F5>", function() dap.continue() end, "[<F5>] Debug Continue")

map("n", "<leader>b", function() dap.toggle_breakpoint() end, "[<leader>b] Debug Toggle [b]reakpoint")
map("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end,
   "[<leader>B] Debug Add conditional [B]reakpoint")
map("n", "<leader>dr", function() dapui.open({ reset = true }) end, "[<leader>dr] [D]ebug UI [R]eset")

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
