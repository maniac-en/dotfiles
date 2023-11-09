require("dap-python").setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}
