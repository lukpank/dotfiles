local function cwd()
  return vim.fn.getcwd()
end

return {
  -- Colorscheme
  {
    'rmehri01/onenord.nvim',
    config = function()
      vim.cmd.colorscheme("onenord")
    end
  },

  'EdenEast/nightfox.nvim',

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
