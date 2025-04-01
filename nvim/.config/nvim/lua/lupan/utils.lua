local M = {}

local filename = os.getenv('HOME') .. '/.config/alacritty/alacritty.toml'

local colorschemes = nil

function M.set_color_schemes(dark, light)
  colorschemes = { dark = dark, light = light }
end

function M.terminalbg()
  local ok, lines = pcall(io.lines, filename)
  if ok then
    for line in lines do
      if string.find(line, 'light.toml') then
        return "light"
      end
    end
  end
  return "dark"
end

function M.update_color_scheme()
  vim.o.background = M.terminalbg()
  if colorschemes then
    vim.cmd.colorscheme(colorschemes[vim.o.background])
  end
end

function M.toggle_color_scheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
  if colorschemes then
    vim.cmd.colorscheme(colorschemes[vim.o.background])
  end
end

local w = vim.uv.new_fs_event()

local function watch(fname)
  w:start(filename, {}, vim.schedule_wrap(function(...)
    M.update_color_scheme()
    w:stop()
    watch(fname)
  end))
end

watch(filename)

return M
