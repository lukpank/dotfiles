return {
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  opts = {
    autoload = true,
    ignored_dirs = {
      "~/.config",
      "~/tmp",
      "/tmp",
      { "~", exact = true },
      { "/", exact = true },
    },
  },
  keys = {
    { "<leader>sp", "<cmd>:Telescope persisted<cr>", desc = "Search [P]ersisted" },
  },
}
