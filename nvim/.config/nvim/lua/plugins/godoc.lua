return {
  {
    'fredrikaverpil/godoc.nvim',
    version = '*',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      {
        'nvim-treesitter/nvim-treesitter',
        opts = {
          ensure_installed = { 'go' },
        },
      },
    },
    event = 'VeryLazy',
    cmd = 'GoDoc',
    keys = {
      { '<leader>gd', '<cmd>GoDoc<CR>', desc = '[G]o[D]oc' },
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
    opts = {
      picker = { type = 'telescope' },
    },
  },
}
