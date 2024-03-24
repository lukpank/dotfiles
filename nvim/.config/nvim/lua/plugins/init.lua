return {
  {
    'crusj/hierarchy-tree-go.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    lazy = true,
  },

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
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
        vim.keymap.set('n', '<leader>T', tsj.toggle, { desc = "[T]oggle one-line" }),
      })
    end,
  },
}
