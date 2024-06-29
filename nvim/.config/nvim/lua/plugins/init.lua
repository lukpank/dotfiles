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
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gS', '<Plug>(leap-from-window)')
    end,
    dependencies = {
      "tpope/vim-repeat",
    },
    lazy = false,
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
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
    end
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts)
      local tsj = require('treesj')
      tsj.setup(opts)
      vim.keymap.set('n', '<leader>tg', tsj.toggle, { desc = "[T]ree to[g]gle one-line" })
      vim.keymap.set('n', '<leader>tj', tsj.join, { desc = "[T]ree [J]oin one-line" })
      vim.keymap.set('n', '<leader>ts', tsj.split, { desc = "[T]ree [S]plit one-line" })
    end,
  },
}
