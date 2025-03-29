vim.opt.fillchars = {
  stl = "─",
}

return {
  {
    "sschleemilch/slimline.nvim",
    opts = {
      spaces = {
        components = "─",
        left = "─",
        right = "─",
      },
    },
  },

  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },
}
