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
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- change directory with telescope from a list of dierectories
  "SalOrak/whaler",
}
