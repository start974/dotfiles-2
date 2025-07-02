return {
  dir = '~/Project/why3find.nvim',
  opts = {},
  config = function(_, opts)
    vim.lsp.enable 'why3find'
  end,
}
