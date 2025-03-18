local function rabbit_select(n)
  require('rabbit').Switch('harpoon').func.select(n)
end

return {
  'VoxelPrismatic/rabbit.nvim',
  event = 'VeryLazy',
  opts = {
    window = {
      float = 'center',
      plugin_name_position = 'title',
    },
    default_keys = {
      open = { '-', '<leader>;' },
    },
    plugin_opts = {
      history = { switch = ';' },
      harpoon = { switch = 'f' },
    },
  },
  keys = {
    { '<leader>1', function() rabbit_select(1) end },
    { '<leader>2', function() rabbit_select(2) end },
    { '<leader>3', function() rabbit_select(3) end },
    { '<leader>4', function() rabbit_select(4) end },
    { '<leader>5', function() rabbit_select(5) end },
    { '<leader>6', function() rabbit_select(6) end },
    { '<leader>7', function() rabbit_select(7) end },
    { '<leader>8', function() rabbit_select(8) end },
    { '<leader>9', function() rabbit_select(9) end },
    { '<leader>0', function() rabbit_select(10) end },
  },
}
