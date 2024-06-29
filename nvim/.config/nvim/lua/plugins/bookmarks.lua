return {
  {
    "LintaoAmons/bookmarks.nvim",
    tag = "v0.5.3",                -- optional, pin the plugin at specific version for stability
    dependencies = {
      { "stevearc/dressing.nvim" } -- optional: to have the same UI shown in the GIF
    },
    event = 'VimEnter',
    keys = {
      { "mm", "<cmd>BookmarksMark<cr>",          mode = { "n", "v" }, desc = "Mark current line into active BookmarkList." },
      { "mo", "<cmd>BookmarksGoto<cr>",          mode = { "n", "v" }, desc = "Go to bookmark at current active BookmarkList" },
      { "ma", "<cmd>BookmarksCommands<cr>",      mode = { "n", "v" }, desc = "Find and trigger a bookmark command." },
      { "mg", "<cmd>BookmarksGotoRecent<cr>",    mode = { "n", "v" }, desc = "Go to latest visited/created Bookmark" },
      { "ms", "<cmd>BookmarksSetActiveList<cr>", mode = { "n", "v" }, desc = "Go to latest visited/created Bookmark" },
    },
  },
  { "nvim-telescope/telescope.nvim", lazy = true },
}
