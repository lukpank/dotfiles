local M = {}

function M.terminalbg()
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

return M
