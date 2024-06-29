return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', '<cmd>Lspsaga rename<CR>', '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
          map('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight references under cursor (clear highlight when cursor moves).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = function()
                local clients = vim.lsp.get_clients({ bufnr = event.buf })
                for _i, cl in ipairs(clients) do
                  if cl.name == 'unocss' then
                    return -- skip highlight if unocss is attached (workaround)
                  end
                end
                vim.lsp.buf.document_highlight()
              end
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        gopls = {},
        -- pyright = {},
        rust_analyzer = {},
        tsserver = {},

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        html = {},
        htmx = {},
        unocss = {},
      }

      require 'lspconfig'.html.setup {
        filetypes = { "html", "templ" },
      }

      require 'lspconfig'.htmx.setup {
        filetypes = { "html", "templ" },
      }

      require 'lspconfig'.unocss.setup {
        filetypes = { "html", "templ" },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      lightbulb = { enable = false }
    },
    config = function(_, opts)
      require('lspsaga').setup(opts)
      vim.keymap.set('n', '<leader>la', '<cmd>Lspsaga code_action<CR>', { desc = "[L]spsaga code [A]ction" })
      vim.keymap.set('n', '<leader>lb', '<cmd>Lspsaga show_buf_diagnostics<CR>',
        { desc = "[L]spsaga [B]uffer diagnostics" })
      vim.keymap.set('n', '<leader>lc', '<cmd>Lspsaga show_cursor_diagnostics<CR>',
        { desc = "[L]spsaga [C]ursor diagnostics" })
      vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga goto_definition<CR>', { desc = "[L]spsaga goto [D]efinition" })
      vim.keymap.set('n', '<leader>lD', '<cmd>Lspsaga goto_type_definition<CR>',
        { desc = "[L]spsaga goto type [D]efinition" })
      vim.keymap.set('n', '<leader>lf', '<cmd>Lspsaga finder<CR>', { desc = "[L]spsaga [F]inder" })
      vim.keymap.set('n', '<leader>lI', '<cmd>Lspsaga finder imp<CR>', { desc = "[L]spsaga finder [I]mplementations" })
      vim.keymap.set('n', '<leader>li', '<cmd>Lspsaga incoming_calls<CR>', { desc = "[L]spsaga [I]ncomping calls" })
      vim.keymap.set('n', '<leader>ll', '<cmd>Lspsaga show_line_diagnostics<CR>',
        { desc = "[L]spsaga [L]ine diagnostics" })
      vim.keymap.set('n', '<leader>lo', '<cmd>Lspsaga outgoing_calls<CR>', { desc = "[L]spsaga [O]utgoing calls" })
      vim.keymap.set('n', '<leader>lO', '<cmd>Lspsaga outline<CR>', { desc = "[L]spsaga [O]utline" })
      vim.keymap.set('n', '<leader>lp', '<cmd>Lspsaga peek_definition<CR>', { desc = "[L]spsaga [P]eek definition" })
      vim.keymap.set('n', '<leader>lP', '<cmd>Lspsaga peek_type_definition<CR>',
        { desc = "[L]spsaga [P]eek type definition" })
      vim.keymap.set('n', '<leader>lw', '<cmd>Lspsaga show_workspace_diagnostics<CR>',
        { desc = "[L]spsaga [W]orkspace diagnostics" })
      vim.keymap.set({ 'n', 't' }, '<C-_>', '<cmd>Lspsaga term_toggle<CR>', { desc = "[L]spsaga [T]erm toggle" })
    end,
  },
}
