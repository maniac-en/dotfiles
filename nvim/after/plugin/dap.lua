-- NOT USING DAP DUE TO BAD UX IN VIM/NEOVIM

-- require("dapui").setup()
--
-- local dap = require("dap")
-- local dapui = require("dapui")

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- debugger mappings

-- vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { noremap = true })
-- vim.keymap.set("n", "<leader>dsi", function() dap.step_into() end, { noremap = true })
-- vim.keymap.set("n", "<leader>dso", function() dap.step_out() end, { noremap = true })
-- -- sort of saying dap step skip
-- vim.keymap.set("n", "<leader>dss", function() dap.step_over() end, { noremap = true })
-- vim.keymap.set("n", "<leader>dt", function() dapui.toggle() end, { noremap = true })
-- vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { noremap = true })
-- vim.keymap.set("n", "<leader>dr", function() dapui.open({reset=true}) end, { noremap = true })

-- setup debugger language-wise
-- require("dap-python").setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
