-- Source: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/configuration-templates.md#primes-config

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end)

require('mason').setup({})
require('mason-lspconfig').setup({

  -- [[ LSP/Linting servers I need
  -- "bash-language-server",
  -- "clangd",
  -- "cpplint",
  -- "css-lsp",
  -- "docker-compose-language-service",
  -- "golangci-lint",
  -- "gopls",
  -- "hadolint",
  -- "html-lsp",
  -- "json-lsp",
  -- "lua-language-server",
  -- "quick-lint-js",
  -- "ruff",
  -- "ruff-lsp",
  -- "sqlfluff",
  -- "sqlls",
  -- "stylelint",
  -- "vim-language-server"
  -- ]]

  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
