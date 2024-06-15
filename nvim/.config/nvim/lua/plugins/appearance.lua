local function cwd()
  return vim.fn.getcwd()
end

return {
  -- Colorscheme
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }
      require('bamboo').load()
      vim.cmd.colorscheme("bamboo-vulgaris")
    end,
  },
  {
    -- Statusline
    'freddiehaddad/feline.nvim',
    opts = {},
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
