local function cwd()
  return vim.fn.getcwd()
end

local function set_bg()
  if vim.o.background == 'dark' then
    vim.cmd.colorscheme("nightfox")
  else
    vim.cmd.colorscheme("dayfox")
  end
end

vim.api.nvim_create_autocmd('OptionSet', {
  callback = set_bg,
  pattern = { 'background' },
})

return {
  -- Colorscheme
  {
    'EdenEast/nightfox.nvim',
    config = function()
      set_bg()
    end
  },

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
