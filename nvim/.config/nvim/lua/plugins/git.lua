return {
  -- Git
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      graph_style = 'unicode',
      use_per_project_settings = false,
    },
    keys = {
      {
        '<leader>go',
        function() require('neogit').open() end,
        desc = 'Neo[g]it [O]pen'
      },
      {
        '<leader>g.',
        function() require('neogit').open({ cwd = '%:p:h' }) end,
        desc = 'Neo[g]it open in current file repository'
      },
      {
        '<leader>gh',
        function() require('diffview').file_history() end,
        desc = '[G]it [H]istory',
      },
      {
        '<leader>g%',
        function() require('diffview').file_history(nil, { '%' }) end,
        desc = '[G]it history for [%] current file'
      },
    },
  },

  {
    'FabijanZulj/blame.nvim',
    config = true,
    cmd = 'BlameToggle',
    keys = {
      { '<leader>gb', '<cmd>BlameToggle<cr>', desc = '[G]it [B]lame toggle' },
    },
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        vim.keymap.set('n', '<leader>gp', gs.prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', gs.next_hunk,
          { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', gs.preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' })
        vim.keymap.set('n', '<leader>sh', gs.stage_hunk,
          { buffer = bufnr, desc = '[S]tage [H]unk' })
        vim.keymap.set('n', '<leader>HD', function() gs.diffthis('~') end,
          { buffer = bufnr, desc = '[H]unk [D]iff' })
      end,
    },
  },
}
