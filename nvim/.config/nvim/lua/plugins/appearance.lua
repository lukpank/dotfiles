local function cwd()
  return vim.fn.getcwd()
end

return {
  -- Colorscheme
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    config = function()
      vim.cmd.colorscheme("nordbones")
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
