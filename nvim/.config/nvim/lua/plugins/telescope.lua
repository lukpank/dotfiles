return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },


      -- change directory with telescope from a list of directories
      {
        "SalOrak/whaler",
        opts = {
          directories = { "/home/lupan/src" },
          oneoff_directories = { "/home/lupan/dotfiles" },
          auto_file_explorer = false,
          auto_cwd = true,
        }
      },

      -- Icons, requires Nerd font.
      { 'nvim-tree/nvim-web-devicons' },

      'davvid/telescope-git-grep.nvim',
    },
    config = function()
      local telescope = require 'telescope'
      -- To list available key bindings inside given telescope picker:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      telescope.setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          whaler = {
            directories = { "/home/lupan/src" },
            oneoff_directories = { "/home/lupan/dotfiles" },
            auto_file_explorer = false,
            auto_cwd = true,
          }
        },
      }

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'whaler')
      pcall(telescope.load_extension, 'git_grep')
      pcall(telescope.load_extension, 'persisted')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sF', function() builtin.find_files { hidden = true } end,
        { desc = '[S]earch [F]iles (with hidden)' })
      vim.keymap.set('n', '<leader>sl', function() telescope.extensions.whaler.whaler() end,
        { desc = '[S]earch with wha[L]er' })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gg', function() telescope.extensions.git_grep.live_grep() end,
        { desc = '[G]it [g]rep' })
      vim.keymap.set('n', '<leader>gw', function() telescope.extensions.git_grep.grep() end,
        { desc = '[G]it grep current [W]ord' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  }

}
