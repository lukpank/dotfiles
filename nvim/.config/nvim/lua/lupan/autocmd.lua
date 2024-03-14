-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format on saving buffer',
  callback = function()
    vim.lsp.buf.format()
  end,
  group = vim.api.nvim_create_augroup('BufWriteFormat', { clear = true }),
  pattern = { '*.go', '*.lua', '*.rs' },
})
