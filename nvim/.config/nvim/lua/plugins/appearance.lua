return {
  -- Colorscheme
  {
    'neanias/everforest-nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require("everforest").setup({
        background = 'hard',
      })
      vim.cmd.colorscheme 'everforest'
    end
  },

  {
    -- Statusline (see `:help lualine.txt`)
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'everforest',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Indentation guides (see `:help indent_blankline.txt`)
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      -- char = '┊',
      -- show_trailing_blankline_indent = false,
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle'
  },
}
