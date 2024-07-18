return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'CurrentMajor',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_snipmate').lazy_load() -- Lazy loading
    end,
    keys = {
      {
        '<C-J>',
        function()
          require('luasnip').jump(1)
        end,
        mode = { 'i', 's' },
        desc = 'Next snippets',
        noremap = true,
        silent = true,
      },
      {
        '<C-K>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
        desc = 'Previous snippets',
        noremap = true,
        silent = true,
      },
    },
  },
}
