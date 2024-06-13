local function cwd()
  return vim.fn.getcwd()
end

return {
  -- Colorscheme
  {
    'rmehri01/onenord.nvim',
    config = function()
      -- vim.cmd.colorscheme("onenord")
    end
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("NeoSolarized")
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme("duskfox")
    end
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
