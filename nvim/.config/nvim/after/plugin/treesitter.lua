local org = require('orgmode')
org.setup_ts_grammar()

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'haskell', 'lua', 'org', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
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

local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
treesitter_parser_config.templ = {
  install_info = {
    url = "https://github.com/vrischmann/tree-sitter-templ.git",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
}

vim.treesitter.language.register('templ', 'templ')

org.setup({
  org_agenda_files = { '~/org/*.org' },
  org_default_notes_file = '~/org/capture.org',
})
