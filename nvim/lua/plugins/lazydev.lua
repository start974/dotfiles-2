return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      -- Types for the `Snacks` global
      { path = 'snacks.nvim', words = { 'Snacks' } },
    },
  },
}
