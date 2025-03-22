return {
  {
    'aserowy/tmux.nvim',
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
    keys = {
      { '<M-h>', [[<cmd>lua require("tmux").move_left()<cr>]] },
      { '<M-j>', [[<cmd>lua require("tmux").move_bottom()<cr>]] },
      { '<M-k>', [[<cmd>lua require("tmux").move_top()<cr>]] },
      { '<M-l>', [[<cmd>lua require("tmux").move_right()<cr>]] },
      { '<M-n>', [[<cmd>lua require("tmux").next_window()<cr>]] },
      { '<M-p>', [[<cmd>lua require("tmux").previous_window()<cr>]] },
      { '<M-H>', [[<cmd>lua require("tmux").resize_left()<cr>]] },
      { '<M-J>', [[<cmd>lua require("tmux").resize_bottom()<cr>]] },
      { '<M-K>', [[<cmd>lua require("tmux").resize_top()<cr>]] },
      { '<M-L>', [[<cmd>lua require("tmux").resize_right()<cr>]] },
    },
  },
}
