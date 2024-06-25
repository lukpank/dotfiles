return {
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = '<leader>;',
      buffer_leader_key = '<leader>m',
    },
    keys = {
      { "<leader>1", function() require("arrow.persist").go_to(1) end },
      { "<leader>2", function() require("arrow.persist").go_to(2) end },
      { "<leader>3", function() require("arrow.persist").go_to(3) end },
      { "<leader>4", function() require("arrow.persist").go_to(4) end },
      { "<leader>5", function() require("arrow.persist").go_to(5) end },
      { "<leader>6", function() require("arrow.persist").go_to(6) end },
      { "<leader>7", function() require("arrow.persist").go_to(7) end },
      { "<leader>8", function() require("arrow.persist").go_to(8) end },
      { "<leader>9", function() require("arrow.persist").go_to(9) end },
      { "<leader>0", function() require("arrow.persist").go_to(10) end },
    }
  }
}
