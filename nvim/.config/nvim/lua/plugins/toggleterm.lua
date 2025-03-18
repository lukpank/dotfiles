return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    { '<F2>',  '<cmd>ToggleTerm size=25<CR>', mode = { 'n', 'i', 't', }, },
    { '<C-w>', [[<C-\><C-n><C-w>]],           mode = 't' },
  }
}
