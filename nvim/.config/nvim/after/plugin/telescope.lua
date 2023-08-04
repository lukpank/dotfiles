pcall(require('telescope').load_extension, 'fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened buffers' })
vim.keymap.set('n', '<leader>/', function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { previewer = false })
end, { desc = '[?] Find recently opened buffers' })

vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [f]iles' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [s]tatus' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [f]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [g]rep' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind [w]ord' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [h]elp (tags)' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [d]iagnostics' })

vim.keymap.set('n', '<leader>fF', function()
	builtin.find_files { hidden = true }
end, { desc = '[F]find [F]iles (with hidden)' })
