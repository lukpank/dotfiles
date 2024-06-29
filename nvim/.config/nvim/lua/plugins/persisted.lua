return {
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  opts = {
    autoload = true,
    ignored_dirs = {
      "~/.config",
      "~/tmp",
      "/tmp",
      { "/", exact = true },
    },
  },
  config = function(_, opts)
    require("persisted").setup(opts)
    require("telescope").load_extension("persisted")
  end,
  keys = {
    { "<leader>sp", "<cmd>:Telescope persisted<cr>", desc = "Search [P]ersisted" },
  },
}
