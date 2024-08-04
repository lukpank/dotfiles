local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

local M = {}

local function enter(prompt_bufnr, action)
  local selected = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  action(selected[1])
end

function M.tab_change_dir(opts)
  opts = opts or {}
  local action = opts.action or vim.cmd.tc
  local prompt_title = opts.prompt_title or "Tab change directory"
  local cmd = { 'find', os.getenv('HOME'), '-maxdepth', '5', '-type', 'd', '-not', '-path', '*/.git*' }
  local dropdown = themes.get_dropdown();
  local picker_opts = {
    prompt_title = prompt_title,
    finder = finders.new_oneshot_job(cmd, {}),
    sorter = sorters.get_fuzzy_file({}),
    attach_mappings = function(_, map)
      map({ "i", "n" }, "<CR>", function(prompt_bufnr) enter(prompt_bufnr, action) end)
      return true
    end
  }
  local change_dir = pickers.new(dropdown, picker_opts)
  change_dir:find()
end

local function tabnew_tcd(dir)
  vim.cmd.tabnew(dir)
  vim.cmd.tc(dir)
end

function M.tab_change_dir_newtab()
  M.tab_change_dir({ action = tabnew_tcd, prompt_title = "Tab change directory (new tab)" })
end

local function append_text(text)
  text = string.gsub(text, "^ + %w+%.([%w%p]+) +.*", "%1")
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { text })
end

function M.find_translation_key(opts)
  opts = opts or {}
  local action = opts.action or append_text
  local prompt_title = opts.prompt_title or "Get translation key"
  local cmd = { 'list-translation-keys' }
  local dropdown = themes.get_dropdown();
  local picker_opts = {
    prompt_title = prompt_title,
    finder = finders.new_oneshot_job(cmd, {}),
    sorter = sorters.get_fuzzy_file({}),
    attach_mappings = function(_, map)
      map({ "i", "n" }, "<CR>", function(prompt_bufnr) enter(prompt_bufnr, action) end)
      return true
    end
  }
  local find_translation_key = pickers.new(dropdown, picker_opts)
  find_translation_key:find()
end

return M
