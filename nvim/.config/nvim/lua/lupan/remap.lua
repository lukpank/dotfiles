vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local key = vim.keymap.set
local opts = { silent = true, noremap = true }

key('v', '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

key("n", "<leader>dd", ":Explore<cr>", { desc = "[D]isplay [d]irectory" })
key("n", "<leader>dv", ":Vexplore<cr>", { desc = "[D]isplay directory ([v]ertical split)" })
key("n", "<leader>dh", ":Sexplore<cr>", { desc = "[D]isplay [d]irectory ([h]orizontal split)" })
key("n", "<leader>dt", ":Lexplore 30<cr>", { desc = "[D]isplay directory [t]oggle" })
key("n", "<leader>ct", ":ColorizerToggle<cr>", { desc = "[C]olorizer [t]oggle" })
key("n", "<leader>ut", ":UndotreeToggle<cr>", { desc = "[U]undotree [t]oggle" })

-- Diagnostic keymaps
key('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
key('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
key('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
key('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

key('n', '<leader>N', ':bn<cr>', { desc = '[N]ext buffer' })
key('n', '<leader>P', ':bp<cr>', { desc = '[P]revious buffer' })

key('n', '<leader>tc', ':tabnew<cr>', { desc = '[T]ab [c]reate' })
key('n', '<leader>ts', ':tab split<cr>', { desc = '[T]ab [s]plit' })
key('n', '<leader>tn', ':tabnext<cr>', { desc = '[T]ab [n]ext' })
key('n', '<leader>tp', ':tabprevious<cr>', { desc = '[T]ab [p]revious' })

key('v', 'J', ":m '>+1<cr>gv=gv", { desc = "Move lines down" })
key('v', 'K', ":m '<-2<cr>gv=gv", { desc = "Move lines up" })

-- Change window
key('n', '<C-j>', '<C-w>j', opts)
key('n', '<C-k>', '<C-w>k', opts)
key('n', '<C-h>', '<C-w>h', opts)
key('n', '<C-l>', '<C-w>l', opts)

-- Stay in key mode
key('v', '<', '<gv', opts)
key('v', '>', '>gv', opts)

-- Keep old value of register
key('v', 'P', '"_dP', opts)

-- luasnip

vim.keymap.set({ 'i', 's' }, "<c-k>", function()
  local ls = require "luasnip"
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, "<c-j>", function()
  local ls = require "luasnip"
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, "<c-l>", function()
  local ls = require "luasnip"
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set("n", "<leader>ss", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>",
  { desc = "[S]nippets [s]ource" })

-- terminal

key('t', '<C-_>', '<C-\\><C-n>')

-- harpoon

key('n', '<leader>ha', function()
  require("harpoon.mark").add_file()
end, { desc = '[H]arpoon [a]dd' })

key('n', '<leader>hm', function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = '[H]arpoon toggle quick [m]enu' })

key('n', '<leader>hj', function()
  require("harpoon.ui").nav_next()
end, { desc = '[H]arpoon next (j)' })

key('n', '<leader>hk', function()
  require("harpoon.ui").nav_prev()
end, { desc = '[H]arpoon prev (k)' })

for i = 1, 9, 1 do
  key('n', '<leader>h' .. i, function()
    require("harpoon.ui").nav_file(i)
  end, { desc = '[H]arpoon nav_file [' .. i .. ']' })
end

for i = 1, 9, 1 do
  key('n', '<leader>t' .. i, function()
    require("harpoon.term").gotoTerminal(i)
  end, { desc = '[H]arpoon nav_file [' .. i .. ']' })
end
