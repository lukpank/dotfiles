vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local key = vim.keymap.set
local opts = { silent = true, noremap = true }

key('v', '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

key("n", "<leader>dd", "<cmd>Oil<CR>", { desc = "[D]isplay [d]irectory" })
key("n", "<leader>df", "<cmd>Oil --float<CR>", { desc = "[D]isplay directory [f]loat" })
key("n", "<leader>ct", "<cmd>ColorizerToggle<CR>", { desc = "[C]olorizer [t]oggle" })
key("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { desc = "[U]undotree [t]oggle" })

-- tabs

key('n', '<leader>td', function()
  require('lupan.ui').tab_change_dir()
end, { desc = '[T]ab change [d]irectory' })

key('n', '<leader>tD', function()
  require('lupan.ui').tab_change_dir_newtab()
end, { desc = '[T]ab change [D]irectory (new tab)' })

key('n', '<leader>tm', function()
  require('telescope-tabs').list_tabs(require 'telescope.themes'.get_dropdown())
end, { desc = '[T]ab change [D]irectory (new tab)' })

key('n', '<leader>tt', function()
  require('telescope-tabs').go_to_previous()
end, { desc = '[T]ab [t]oggle previous' })

for i = 1, 9, 1 do
  key('n', '<leader>t' .. i, '<cmd>' .. i .. 'tabnext<CR>', { desc = '[T]ab nr [' .. i .. ']' })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

key('n', '<leader>N', '<cmd>bn<CR>', { desc = '[N]ext buffer' })
key('n', '<leader>P', '<cmd>bp<CR>', { desc = '[P]revious buffer' })

key('n', '<leader>tc', '<cmd>tabnew<CR>', { desc = '[T]ab [c]reate' })
key('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = '[T]ab close' })
key('n', '<leader>ts', '<cmd>tab split<CR>', { desc = '[T]ab [s]plit' })
key('n', '<leader>tn', '<cmd>tabnext<CR>', { desc = '[T]ab [n]ext' })
key('n', '<leader>tp', '<cmd>tabprevious<CR>', { desc = '[T]ab [p]revious' })
key('n', '<leader>tf', '<cmd>tabfirst<CR>', { desc = '[T]ab [f]irst' })
key('n', '<leader>tl', '<cmd>tablast<CR>', { desc = '[T]tab [l]ast' })

key('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
key('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

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

-- LightSpeed
key('n', 'g/', '<Plug>Lightspeed_s', { desc = "Lightspeed forward search" })
key('n', 'g?', '<Plug>Lightspeed_S', { desc = "Lightspeed backward search" })

-- Clipboard and quickfix
key({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Yank to clipboard" })
key('n', '<leader>j', '<cmd>cn<CR>', { desc = "Quickfix next" })
key('n', '<leader>k', '<cmd>cp<CR>', { desc = "Quickfix previous" })
key('n', '<leader>co', '<cmd>copen<CR>', { desc = "Quickfix [O]pen" })
key('n', '<leader>cc', '<cmd>cclose<CR>', { desc = "Quickfix [C]lose" })
key('n', '<leader>ct', '<cmd>TroubleToggle<CR>', { desc = "Toggle [T]rouble" })

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

-- colors

key('n', '<F6>', function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end)
