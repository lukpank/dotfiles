local function terminalbg()
  local ok, lines = pcall(io.lines, os.getenv('HOME') .. '/.config/alacritty/alacritty.toml')
  if ok then
    for line in lines do
      if string.find(line, 'light.toml') then
        return "light"
      end
    end
  end
  return "dark"
end

return {
  {
    -- Colorscheme
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = terminalbg()
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    -- Indentation guides (see `:help indent_blankline.txt`)
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },

  {
    --- Create Color Code
    'uga-rosa/ccc.nvim',
    config = function(_, opts)
      require('ccc').setup(opts)
    end,
    cmd = { 'CccPick', 'CccHighlighterToggle' },
    keys = {
      { "<leader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "[C]olorizer [T]oggle" },
      { "<leader>cp", "<cmd>CccPick<cr>",              desc = "[C]olor [P]ick" },
    },
  },
}
