return {
  dir = '~/Project/why3find.nvim',
  opts = {},
  cond = not vim.g.vscode,  -- disable in VSCode
  config = function(_, opts)
    vim.lsp.enable 'why3find'
  end,
}
