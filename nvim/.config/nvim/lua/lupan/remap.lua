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

-- telescope

key('n', '<leader><space>', '<cmd>Telescope buffers<cr>', { desc = '[ ] Find existing buffers' })
key('n', '<leader>?', '<cmd>Telescope oldfiles<cr>', { desc = '[?] Find recently opened buffers' })
key('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { previewer = false })
end, { desc = '[/] Find in current buffer' })

key('n', '<leader>gf', '<cmd>Telescope git_files<cr>', { desc = '[G]it [f]iles' })
key('n', '<leader>gs', '<cmd>Telescope git_status<cr>', { desc = '[G]it [s]tatus' })
key('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [f]iles' })
key('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind [g]rep' })
key('n', '<leader>fw', '<cmd>Telescope grep_string<cr>', { desc = '[F]ind [w]ord' })
key('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [h]elp (tags)' })
key('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = '[F]ind [d]iagnostics' })
key('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = '[F]ind [k]eymaps' })

key('n', '<leader>fF', function()
  require('telescope.builtin').find_files { hidden = true }
end, { desc = '[F]ind [F]iles (with hidden)' })

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
  key('n', '<leader>t' .. i, '<cmd>' .. i .. 'tabnext<cr>', { desc = '[T]ab nr [' .. i .. ']' })
end

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
key('n', '<leader>tf', ':tabfirst<cr>', { desc = '[T]ab [f]irst' })
key('n', '<leader>tl', ':tablast<cr>', { desc = '[T]tab [l]ast' })

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

-- LightSpeed
key('n', 'g/', '<Plug>Lightspeed_s', { desc = "Lightspeed forward search" })
key('n', 'g?', '<Plug>Lightspeed_S', { desc = "Lightspeed backward search" })

-- Clipboard and quickfix
key({ 'n', 'v' }, '<leader>y', '"+y', { desc = "Yank to clipboard" })
key('n', '<leader>j', ':cn<CR>', { desc = "Quickfix next" })
key('n', '<leader>k', ':cp<CR>', { desc = "Quickfix previous" })

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
  key('n', '<M-' .. i .. '>', function()
    require("harpoon.ui").nav_file(i)
  end, { desc = '[H]arpoon nav_file [' .. i .. ']' })
end

for i = 1, 9, 1 do
  key('n', '<leader>T' .. i, function()
    require("harpoon.term").gotoTerminal(i)
  end, { desc = '[H]arpoon nav_file [' .. i .. ']' })
end

-- colors

key('n', '<F6>', function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end)
