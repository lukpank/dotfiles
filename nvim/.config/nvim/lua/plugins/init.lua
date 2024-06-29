return {
  {
    'crusj/hierarchy-tree-go.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    lazy = true,
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
      { 'gs', '<Plug>(leap)',             mode = { 'n', 'x', 'o' } },
      { 'gS', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' } },
    }
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
    },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
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
