-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#change-directory
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#ripgrep-remove-indentation
      "--trim"
    }
  }
}

-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, { desc = '[o] Find recently opened files' })

vim.keymap.set('n', '<leader>/',
  function()
    builtin.current_buffer_fuzzy_find(
      require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
        layout_config = {
          height = 0.75,
          width = 0.75
        }
      })
  end, { desc = '[/] Fuzzily search in current buffer' }
)

-- search files in entire git dir if in a git directoy
function vim.find_files_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end
vim.keymap.set('n', '<M-p>', builtin.git_files, { silent = true, desc = 'Search Git Files' })

-- search files in current dir
vim.keymap.set('n', '<C-p>', vim.find_files_from_project_git_root, { silent = true, desc = '[S]earch [F]iles' })

-- grep search in current dir
vim.keymap.set('n', '<C-f>', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = '[G]rep [S]earch ' })

-- search vim help docs
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { silent = true, desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { silent = true, desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { silent = true, desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { silent = true, desc = '[S]earch [R]esume' })
