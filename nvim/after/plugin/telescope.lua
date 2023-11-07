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

-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return current_dir
  end
  return git_root
end

-- Function to find the irectory based on the current buffer's path
local function find_cwd()
  -- Use the current buffer's path as the starting point
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  return current_dir
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = {git_root},
        winblend = 10,
        layout_config = {
          height = 0.9,
          width = 0.9
        }
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
vim.keymap.set('n', '<C-f>', live_grep_git_root, { silent = true, desc = 'Grep Git Files' })

-- search files in entire git dir if in a git directoy
local function find_files_git_root()
  local git_root = find_git_root()
  local opts = {}
  if git_root then
    opts = {
      cwd = git_root,
      winblend = 10,
      layout_config = {
        height = 0.9,
        width = 0.9
      }
    }
    require("telescope.builtin").find_files(opts)
  end
end
vim.api.nvim_create_user_command('FindFilesGitRoot', find_files_git_root, {})
vim.keymap.set('n', '<C-p>', find_files_git_root, { silent = true, desc = 'Find Git Files' })

-- search files in current dir
local function find_files()
  local current_dir = find_cwd()
  local opts = {}
  if current_dir then
    opts = {
      cwd = current_dir,
      winblend = 10,
      layout_config = {
        height = 0.9,
        width = 0.9
      }
    }
    require("telescope.builtin").find_files(opts)
  end
end
vim.api.nvim_create_user_command('FindFiles', find_files, {})
vim.keymap.set('n', '<M-p>', find_files, { silent = true, desc = 'Find Files' })

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { silent = true, desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { silent = true, desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { silent = true, desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { silent = true, desc = '[S]earch [R]esume' })
