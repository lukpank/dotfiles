return {
  'backdround/global-note.nvim',
  keys = {
    {
      "<leader>n",
      function()
        require('global-note').toggle_note()
      end,
      desc = 'Toggle global [N]ote',
    },
  },
}
