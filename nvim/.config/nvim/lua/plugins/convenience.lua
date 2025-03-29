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
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { width = 180 },
      plugins = {
        tmux = { enabled = true },
      },
      on_open = function()
        vim.opt.laststatus = 1
        require('incline').disable()
        vim.system({ 'hyprctl', 'dispatch', 'fullscreen' })
        vim.system({ 'awesome-client', 'client.focus.fullscreen = true' })
      end,
      on_close = function()
        vim.opt.laststatus = 3
        require('incline').enable()
        vim.system({ 'hyprctl', 'dispatch', 'fullscreen' })
        vim.system({ 'awesome-client', 'client.focus.fullscreen = false' })
      end
    },
    keys = { { "<leader>z", "<cmd>ZenMode<CR>" } },
  },
}
