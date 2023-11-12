-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#change-directory
require("telescope").setup {
  defaults = {
    layout_config = {
      prompt_position = 'top'
    },
    sorting_strategy = 'ascending',
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
local map = function(mode, lhs, rhs, desc)
  if desc then
    desc = "MANIAC_TELESCOPE: " .. desc
  end
  vim.keymap.set(mode, lhs, rhs, { silent = true, remap = false, desc = desc })
end

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

map("n", "<leader><space>", builtin.buffers, "[<leader><space>] Find existing buffers")
map("n", "<leader>o", require('telescope.builtin').oldfiles, "[<leader>o] Find recently [O]pened files")

-- [C-/] for me is 
map("n", "",
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
  end,
  "[C-/] Fuzzily search in current buffer")

-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local is_git_dir = 1
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
  ---@diagnostic disable-next-line: param-type-mismatch
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    is_git_dir = 0
    print("Not a git repository. Searching on current working directory")
    return current_dir, is_git_dir
  end
  return git_root, is_git_dir
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
  local git_root, _ = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
      winblend = 10,
      layout_config = {
        height = 0.9,
        width = 0.9,
      },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
map("n", "<C-f>", live_grep_git_root, "[<C-f>] Grep (Maybe Git) Files")

-- search files in entire git dir if in a git directoy
local function find_files_git_root()
  local git_root, is_git_dir = find_git_root()
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
    if is_git_dir ~= 0 then
      require("telescope.builtin").git_files(opts)
    else
      require("telescope.builtin").find_files(opts)
    end
  end
end
vim.api.nvim_create_user_command('FindFilesGitRoot', find_files_git_root, {})
map("n", "<C-p>", find_files_git_root, "[<C-p>] Find (Maybe Git) Files")

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
map("n", "<M-p>", find_files, "[<M-p>] Find Files in cwd")

map("n", "<leader>sh", builtin.help_tags, "[<leader>sh] [S]earch [H]elp")
map("n", "<leader>sw",
  function()
    builtin.grep_string(
      require('telescope.themes').get_ivy(
        {
          cwd = find_git_root(),
        }
      )
    )
  end,
  "[<leader>sw] [S]earch current [W]ord")
map("n", "<leader>sr", builtin.resume, "[<leader>sr] [S]earch [R]esume")
map("n", "<leader>ss", function()
    local search_query = vim.fn.input('Grep > ')
    if search_query ~= "" then
      builtin.grep_string(
        require('telescope.themes').get_ivy({
          cwd = find_git_root(),
          search = search_query,
          use_regex = true,
        }))
    end
  end,
  "[<leader>ss] [S]earch [S]tring")
