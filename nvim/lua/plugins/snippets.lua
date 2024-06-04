return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    dependencies = { 'rafamadriz/friendly-snippets' },
    keys = {
      {
        '<C-K>',
        function()
          require('luasnip').expand()
        end,
        mode = 'i',
        desc = "Expand snippets"
      },
      {
        '<C-L>',
        function()
          require('luasnip').jump(1)
        end,
        mode = { 'i', 's' },
        desc = "Next snippets"
      },

      {
        '<C-J>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = { 'i', 's' },
        desc = "Previous snippets"
      },

      {
        '<C-E>',
        function()
          local ls = require 'luasnip'
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = { 'i', 's' },
        desc = "Changing active choise snippets"
      },
    }
  },
}
