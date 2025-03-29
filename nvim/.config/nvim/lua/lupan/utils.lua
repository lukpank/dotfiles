local M = {}

local filename = os.getenv('HOME') .. '/.config/alacritty/alacritty.toml'

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

local w = vim.uv.new_fs_event()

local function watch(fname)
  w:start(filename, {}, vim.schedule_wrap(function(...)
    vim.o.background = M.terminalbg()
    w:stop()
    watch(fname)
  end))
end

watch(filename)

return M
