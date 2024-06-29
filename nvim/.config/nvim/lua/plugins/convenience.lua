return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function(_, opts)
      require('which-key').setup(opts)

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode/Color', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
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
