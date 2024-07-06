return {

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-orgmode/orgmode',   -- as configured together
      'vrischmann/tree-sitter-templ',
      "nushell/tree-sitter-nu", -- additional parser
    },
    build = ':TSUpdate',
    config = function()
      -- See `:help nvim-treesitter`
      local org = require('orgmode')

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'go', 'haskell', 'lua', 'org', 'python', 'rust', 'tsx', 'templ', 'typescript', 'vimdoc', 'vim' },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<C-p>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['al'] = '@call.outer',
              ['il'] = '@call.inner',
              ['ao'] = '@loop.outer',
              ['io'] = '@loop.inner',
              ['ad'] = '@conditional.outer',
              ['id'] = '@conditional.inner',
              ['ar'] = '@return.outer',
              ['ir'] = '@return.inner',
              ['as'] = '@statement.outer',
              ['ag'] = '@assignment.outer',
              ['ig'] = '@assignment.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
      org.setup({
        org_agenda_files = { '~/org/*.org' },
        org_default_notes_file = '~/org/capture.org',
      })
    end,
  }
}
