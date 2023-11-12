local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- recall the last cursor position
  'farmergreg/vim-lastplace',

  -- Git related plugins
  { 'tpope/vim-fugitive', dependencies = { 'tpope/vim-rhubarb', } },

  -- fast git commit browser
  { 'junegunn/gv.vim',    dependencies = { 'tpope/vim-fugitive' } },

  -- add/delete/update surroundings in pairs
  'tpope/vim-surround',

  -- better dot repeats

  "tpope/vim-repeat",

  -- some handy maps
  'tpope/vim-unimpaired',

  -- delicious netrw
  'tpope/vim-vinegar',

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    config = function()
      vim.o.tabstop = 2
      vim.o.softtabstop = 2
      vim.o.shiftwidth = 2
      vim.o.expandtab = true
    end
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- NOTE: install "make" in your system for this to work
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- zen mode
  { "folke/zen-mode.nvim",   opts = {} },

  -- undotree
  "mbbill/undotree",

  -- flow state reading
  "nullchilly/fsread.nvim",

  -- lsp setup using lsp-zero
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "folke/neodev.nvim", opts = {}
    }
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
  },
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-path',
  'tjdevries/complextras.nvim',

  -- dap
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",

  -- devicons
  "kyazdani42/nvim-web-devicons",
})
