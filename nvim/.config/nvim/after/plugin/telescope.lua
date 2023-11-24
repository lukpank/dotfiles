local telescope = require 'telescope'

telescope.setup({
  extensions = {
    whaler = {
      directories = { "/home/lupan/src" },
      oneoff_directories = { "/home/lupan/dotfiles" },
      auto_file_explorer = false,
      auto_cwd = true,
    }
  }
})

telescope.load_extension("whaler")
