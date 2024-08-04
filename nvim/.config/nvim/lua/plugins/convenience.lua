return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function(_, opts)
      require('which-key').setup(opts)

      -- Document existing key chains
      require('which-key').add {
        { "<leader>c", group = "[C]ode/Color" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>g", group = "[G]it" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
      }
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },
}
