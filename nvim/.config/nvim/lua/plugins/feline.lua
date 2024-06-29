local function feline_config(_, opts)
  local feline = require('feline')

  local dark_theme = {
    bg = '#615853',
    bg2 = '#352f2d',
    black = '#403833',
    skyblue = '#61abda',
    cyan = '#65b8c1',
    fg = '#b4bdc3',
    green = '#8bae68',
    oceanblue = '#6099c0',
    magenta = '#cf86c1',
    orange = '#d68c67',
    red = '#e8838f',
    violet = '#b279a7',
    white = '#b4bdc3',
    yellow = '#b77e64',
  }
  feline.add_theme('dark', dark_theme)

  local light_theme = {
    bg = '#e1dcd9',
    bg2 = '#d6cdc9',
    black = '#c4b6af',
    skyblue = '#1d5573',
    cyan = '#2b747c',
    fg = '#2c363c',
    green = '#3f5a22',
    oceanblue = '#286486',
    magenta = '#7b3b70',
    orange = '#803d1c',
    red = '#94253e',
    violet = '#88507d',
    white = '#4f5e68',
    yellow = '#944927',
  }
  feline.add_theme('light', light_theme)

  local statusline = require('arrow.statusline')
  local vimode = require('feline.providers.vi_mode')
  local c = {
    vi_mode = {
      provider = 'vi_mode',
      hl = function()
        return {
          name = vimode.get_mode_highlight_name(),
          fg = vimode.get_mode_color(),
          bg = 'bg2',
          style = 'bold',
        }
      end,
      left_sep = {
        str = ' █',
        always_visible = true,
        hl = {
          fg = 'bg2',
        },
      },
      right_sep = {
        str = '',
        always_visible = true,
        hl = {
          fg = 'bg2',
        },
      }
    },
    file_info = {
      provider = 'file_info',
      hl = {
        fg = 'fg',
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
        fg = 'red',
        style = 'bold',
      },
    },
    file_size = {
      provider = 'file_size',
      hl = {
        fg = 'fg',
        bg = 'bg2',
        style = 'bold',
      },
      left_sep = {
        str = '  █',
        always_visible = true,
        hl = {
          fg = 'bg2',
        },
      },
    },
    line_percentage = {
      provider = 'line_percentage',
      hl = {
        fg = 'fg',
        bg = 'bg2',
        style = 'bold',
      },
      left_sep = {
        str = ' │ ',
        hl = {
          fg = 'fg',
          bg = 'bg2',
        },
      },
      right_sep = {
        str = ' │ ',
        hl = {
          fg = 'fg',
          bg = 'bg2',
        },
      },
    },
    position = {
      provider = 'position',
      hl = {
        fg = 'fg',
        bg = 'bg2',
        style = 'bold',
      },
      right_sep = {
        str = '█ ',
        always_visible = true,
        hl = {
          fg = 'bg2',
        },
      }
    },

    diagnostic_errors = {
      provider = 'diagnostic_errors',
      hl = {
        fg = 'red',
      },
    },
    diagnostic_warnings = {
      provider = 'diagnostic_warnings',
      hl = {
        fg = 'yellow',
      },
    },
    diagnostic_hints = {
      provider = 'diagnostic_hints',
      hl = {
        fg = 'cyan',
      },
    },
    diagnostic_info = {
      provider = 'diagnostic_info',
      hl = {
        fg = 'skyblue',
      },
    },

    git_diff_added = {
      provider = 'git_diff_added',
      hl = {
        fg = 'green',
      },
    },
    git_diff_removed = {
      provider = 'git_diff_removed',
      hl = {
        fg = 'red',
      },
    },
    git_diff_changed = {
      provider = 'git_diff_changed',
      hl = {
        fg = 'yellow',
      },
    },
    git_branch = {
      provider = 'git_branch',
      hl = {
        fg = 'fg',
        bg = 'bg2',
        style = 'bold',
      },
      left_sep = {
        str = '  █',
        hl = {
          fg = 'bg2',
        },
      },
      right_sep = {
        str = ' ',
        hl = {
          fg = 'bg2',
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
  feline.setup(opts)
  feline.use_theme(require('lupan.utils').terminalbg())
end

return {
  -- Statusline
  'freddiehaddad/feline.nvim',
  opts = {},
  config = feline_config,
}
