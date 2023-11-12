local lsp_zero = require('lsp-zero')
local tele_builtin = require('telescope.builtin')

local map = function(mode, lhs, rhs, desc, bufnr)
  if desc then
    desc = "MANIAC_LSP: " .. desc
  end
  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, remap = false, desc = desc })
end

lsp_zero.on_attach(function(_, bufnr)
  map("n", "gd", tele_builtin.lsp_definitions, "[gd] [G]et [D]efinition via telescope", bufnr)
  map("n", "<leader>sd", tele_builtin.diagnostics, "[<leader>sd] Show [D]iagnostics via telescope", bufnr)
  map("n", "K", vim.lsp.buf.hover, "[K] Display hover info about symbol", bufnr)
  map("i", "<C-k>", vim.lsp.buf.signature_help, "[C-k] Display signature help about symbol", bufnr)
  map("n", ",ds", tele_builtin.lsp_document_symbols, "[<leader>ds] Get [D]ocument [S]ymbols via telescope", bufnr)
  map("n", "<leader>ws", tele_builtin.lsp_dynamic_workspace_symbols, "[<leader>ws] Get dynamic [W]orkspace [S]ymbols",
    bufnr)
  map("n", "<leader>fd", vim.diagnostic.open_float, "[<leader>fd] Show [F]loating [D]iagnostic window", bufnr)
  map("n", "[d", vim.diagnostic.goto_next, "[[d] Next diagnostic", bufnr)
  map("n", "]d", vim.diagnostic.goto_prev, "[]d] Prev diagnostic", bufnr)
  map("n", "<leader>ca", vim.lsp.buf.code_action, "[<leader>ca] Show possible [C]ode [A]ctions", bufnr)
  map("n", "<leader>vr", tele_builtin.lsp_references, "[<leader>vr] [V]iew [R]eferences", bufnr)
  map("n", "<leader>rn", vim.lsp.buf.rename, "[<leader>rn] [R]e[Name] current symbol", bufnr)

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
