return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()
      vim.keymap.set('n', '<leader>i', function() harpoon:list():append() end, { desc = "Harpoon add new [I]tem" })
      vim.keymap.set('n', '<leader>m', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Harpoon [M]enu" })
      for i = 1, 9, 1 do
        vim.keymap.set('n', '<M-' .. i .. '>', function() harpoon:list():select(i) end)
      end
    end
  },
}
