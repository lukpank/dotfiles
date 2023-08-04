vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>dd", ":Explore<cr>", { desc = "[D]isplay [d]irectory" })
vim.keymap.set("n", "<leader>ct", ":ColorizerToggle<cr>", { desc = "[C]olorizer [t]oggle" })
vim.keymap.set("n", "<leader>ut", ":UndotreeToggle<cr>", { desc = "[U]undotree [t]oggle" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>N', ':bn<cr>', { desc = '[N]ext buffer' })
vim.keymap.set('n', '<leader>P', ':bp<cr>', { desc = '[P]revious buffer' })

vim.keymap.set('n', '<leader>tc', ':tabnew<cr>', { desc = '[T]ab [c]reate' })
vim.keymap.set('n', '<leader>ts', ':tab split<cr>', { desc = '[T]ab [s]plit' })
vim.keymap.set('n', '<leader>tn', ':tabnext<cr>', { desc = '[T]ab [n]ext' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<cr>', { desc = '[T]ab [p]revious' })

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = "Move lines down" })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = "Move lines up" })
