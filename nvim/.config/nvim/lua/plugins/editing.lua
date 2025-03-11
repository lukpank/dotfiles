return {
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  -- Undo browsing
  'mbbill/undotree',

  -- Tabstops autodetected
  'tpope/vim-sleuth',

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end
  },

  {
    'inkarkat/vim-ReplaceWithRegister',
    keys = {
      { '<leader>r',  '<Plug>ReplaceWithRegisterOperator' },
      { '<leader>rr', '<Plug>ReplaceWithRegisterLine' },
      { '<leader>r',  '<Plug>ReplaceWithRegisterVisual',  mode = 'x' },
    },
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { keymaps = { useDefaults = true } },
  },

  {
    'ggandor/leap.nvim',
    opts = {
      safe_labels = {},
    },
    dependencies = {
      "tpope/vim-repeat",
    },
    keys = {
      { '\\', '<Plug>(leap)',             mode = { 'n', 'x', 'o' } },
      { 'gs', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' } },
    }
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { '<leader>tg', function() require('treesj').toggle() end, desc = "[T]ree to[g]gle one-line" },
      { '<leader>tj', function() require('treesj').join() end,   desc = "[T]ree [J]oin one-line" },
      { '<leader>ts', function() require('treesj').split() end,  desc = "[T]ree [S]plit one-line" },
    },
  },
}
