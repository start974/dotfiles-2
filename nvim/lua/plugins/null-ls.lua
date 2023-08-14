return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'mason.nvim', 'jose-elias-alvarez/null-ls.nvim' },
  config = function()
    local nls = require 'null-ls'
    nls.setup {
      root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'Makefile', '.git'),
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.flake8,
      },
    }
  end,
}
