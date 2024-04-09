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
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local tsj = require('treesj')
      tsj.setup({
        use_default_keymaps = false,
      })
      vim.keymap.set('n', '<leader>tg', tsj.toggle, { desc = "[T]ree to[g]gle one-line" })
      vim.keymap.set('n', '<leader>tj', tsj.join, { desc = "[T]ree [J]oin one-line" })
      vim.keymap.set('n', '<leader>ts', tsj.split, { desc = "[T]ree [S]plit one-line" })
    end,
  },
}
