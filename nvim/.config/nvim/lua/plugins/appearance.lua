return {
  {
    "ramojus/mellifluous.nvim",
    branch = "v1",
  },
  {
    'rmehri01/onenord.nvim',
  },
  {
    'AlexvZyl/nordic.nvim',
  },
  {
    "savq/melange-nvim",
  },
  {
    'ronisbr/nano-theme.nvim',
    config = function()
      local nano = require('nano-theme.colors')
      local nano_get = nano.get
      function nano.get()
        local t = nano_get()
        local light = vim.o.background == 'light'
        if not light then
          t.nano_strong.fg = '#ECEFF4'
        end
        return t
      end

      require('lupan.utils').set_color_schemes('nano-theme', 'nano-theme')
      require('lupan.utils').update_color_scheme()
    end
  },
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
