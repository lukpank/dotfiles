local function feline_config(_, opts)
  local theme = {
    bg = '#394b70',
    black = '#1d202f',
    skyblue = '#7aa2f7',
    cyan = '#0db9d7',
    fg = '#c0caf5',
    green = '#1abc9c',
    oceanblue = '#3d59a1',
    magenta = '#bb9af7',
    orange = '#ff9e64',
    red = '#f7768e',
    violet = '#9d7cd8',
    white = '#a9b1d6',
    yellow = '#e0af68',
  }

  local statusline = require('arrow.statusline')
  local vimode = require('feline.providers.vi_mode')
  local c = {
    vi_mode = {
      provider = 'vi_mode',
      hl = function()
        return {
          name = vimode.get_mode_highlight_name(),
          fg = vimode.get_mode_color(),
          bg = theme.fg,
          style = 'bold',
        }
      end,
      left_sep = {
        str = ' █',
        always_visible = true,
        hl = {
          fg = theme.fg,
        },
      },
      right_sep = {
        str = '',
        always_visible = true,
        hl = {
          fg = theme.fg,
        },
      }
    },
    file_info = {
      provider = 'file_info',
      hl = {
        fg = theme.fg,
      },
      left_sep = {
        str = '  ',
      },
      right_sep = {
        str = '  ',
      },
    },
    arrow = {
      provider = function() return statusline.text_for_statusline_with_icons() end,
      hl = {
        fg = theme.red,
        style = 'bold',
      },
    },
    file_size = {
      provider = 'file_size',
      hl = {
        fg = theme.bg,
        bg = theme.fg,
        style = 'bold',
      },
      left_sep = {
        str = '  █',
        always_visible = true,
        hl = {
          fg = theme.fg,
        },
      },
    },
    line_percentage = {
      provider = 'line_percentage',
      hl = {
        fg = theme.bg,
        bg = theme.fg,
        style = 'bold',
      },
      left_sep = {
        str = ' │ ',
        hl = {
          fg = theme.bg,
          bg = theme.fg,
        },
      },
      right_sep = {
        str = ' │ ',
        hl = {
          fg = theme.bg,
          bg = theme.fg,
        },
      },
    },
    position = {
      provider = 'position',
      hl = {
        fg = theme.bg,
        bg = theme.fg,
        style = 'bold',
      },
      right_sep = {
        str = '█ ',
        always_visible = true,
        hl = {
          fg = theme.fg,
        },
      }
    },
    diagnostic_errors = {
      provider = 'diagnostic_errors',
      hl = {
        fg = theme.red,
      },
    },
    diagnostic_warnings = {
      provider = 'diagnostic_warnings',
      hl = {
        fg = theme.yellow,
      },
    },
    diagnostic_info = {
      provider = 'diagnostic_info',
      hl = {
        fg = theme.green,
      },
    },
    diagnostic_hints = {
      provider = 'diagnostic_hints',
      hl = {
        fg = theme.blue,
      },
    },

    git_diff_added = {
      provider = 'git_diff_added',
      hl = {
        fg = theme.green,
      },
    },
    git_diff_removed = {
      provider = 'git_diff_removed',
      hl = {
        fg = theme.red,
      },
    },
    git_diff_changed = {
      provider = 'git_diff_changed',
      hl = {
        fg = theme.yellow,
      },
    },
    git_branch = {
      provider = 'git_branch',
      hl = {
        fg = theme.bg,
        bg = theme.fg,
        style = 'bold',
      },
      left_sep = {
        str = '  █',
        hl = {
          fg = theme.fg,
        },
      },
      right_sep = {
        str = ' ',
        hl = {
          fg = theme.fg,
        },
      }
    },
  }

  local active = {
    {
      c.vi_mode,
      c.file_info,
      c.arrow,
      c.file_size,
      c.line_percentage,
      c.position,
      c.diagnostic_errors,
      c.diagnostic_warnings,
      c.diagnostic_info,
      c.diagnostic_hints,
    },
    {
      c.git_diff_added,
      c.git_diff_removed,
      c.git_diff_changed,
      c.git_branch,
    },
  }

  local inactive = {
    {
      c.file_info,
    },
    {},
  }

  opts.components = { active = active, inactive = inactive }
  local feline = require('feline')
  feline.setup(opts)
  feline.use_theme(theme)
end

return {
  -- Statusline
  'freddiehaddad/feline.nvim',
  opts = {},
  config = feline_config,
}
