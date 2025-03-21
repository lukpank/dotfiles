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
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
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

  -- rehighlight search on n or N
  {
    'nvimdev/hlsearch.nvim',
    event = 'BufRead',
    config = true,
  },

  {
    'mizlan/iswap.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>cs', '<cmd>ISwapWith<CR>',     desc = 'I[S]wap' },
      { '<leader>cS', '<cmd>ISwap<CR>',         desc = 'I[S]wapWith' },
      { '<leader>cn', '<cmd>ISwapNodeWith<CR>', desc = 'ISwap[N]ode' },
      { '<leader>cN', '<cmd>ISwapNode<CR>',     desc = 'ISwap[N]ode' },
    },
  },

  {
    'aaronik/treewalker.nvim',
    keys = {
      { '<leader>ch', '<cmd>Treewalker Left<CR>',     desc = 'Tree Left' },
      { '<leader>cj', '<cmd>Treewalker Down<CR>',     desc = 'Tree Down' },
      { '<leader>ck', '<cmd>Treewalker Up<CR>',       desc = 'Tree Up' },
      { '<leader>cl', '<cmd>Treewalker Right<CR>',    desc = 'Tree Right' },
      { '<leader>cJ', '<cmd>Treewalker SwapDown<CR>', desc = 'Tree Swap Down' },
      { '<leader>cK', '<cmd>Treewalker SwapUp<CR>',   desc = 'Tree Swap Up' },
    },
  },

  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup()
    end
  },
}
