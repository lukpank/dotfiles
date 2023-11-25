local function cwd()
  return vim.fn.getcwd()
end

return {
  -- Colorscheme
  {
    'rmehri01/onenord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme onenord]]
    end,
  },
  'neanias/everforest-nvim',
  'bluz71/vim-nightfly-colors',
  'bluz71/vim-moonfly-colors',
  'Verf/deepwhite.nvim',

  {
    -- Statusline (see `:help lualine.txt`)
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = { cwd, 'encoding', 'fileformat', 'filetype' }
      }
    },
  },

  {
    -- Indentation guides (see `:help indent_blankline.txt`)
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle'
  },
}
