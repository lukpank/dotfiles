return {
  {
    -- Colorscheme
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.o.background = require('lupan.utils').terminalbg()
      vim.cmd.colorscheme('zenbones')
    end,
  },
  "slugbyte/lackluster.nvim",
  "folke/tokyonight.nvim",
  {
    -- Indentation guides (see `:help indent_blankline.txt`)
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },

  {
    --- Create Color Code
    'uga-rosa/ccc.nvim',
    config = function(_, opts)
      require('ccc').setup(opts)
    end,
    cmd = { 'CccPick', 'CccHighlighterToggle' },
    keys = {
      { "<leader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "[C]olorizer [T]oggle" },
      { "<leader>cp", "<cmd>CccPick<cr>",              desc = "[C]olor [P]ick" },
    },
  },
}
