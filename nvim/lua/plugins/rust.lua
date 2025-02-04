return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  },
  opt = {
    server = {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    },
  },
}
