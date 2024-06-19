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
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle'
  },
}
