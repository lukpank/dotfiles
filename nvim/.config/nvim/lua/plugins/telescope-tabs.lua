local function get_tab_idx(tab_id)
  for i, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
    if tabnr == tab_id then
      return i
    end
  end
  return -1
end

return {
  'LukasPietzschmann/telescope-tabs',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  lazy = true,
  config = function()
    require 'telescope-tabs'.setup {
      entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
        local cwd = vim.fn.getcwd(-1, get_tab_idx(tab_id))
        local entry_string = table.concat(file_names, ', ')
        return string.format('%d: %s %s%s', tab_id, cwd, entry_string, is_current and ' <' or '')
      end,
      entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
        local cwd = vim.fn.getcwd(-1, get_tab_idx(tab_id))
        local entry_string = table.concat(file_names, ', ')
        return string.format('%s %s', cwd, entry_string)
      end,
    }
  end
}
