return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
              { text = { '%s' },                  click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    event = 'BufReadPost',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        mode = 'n',
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        mode = 'n',
        desc = 'Close all folds',
      },
      {
        'K',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor(true)
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        mode = 'n',
        desc = 'LSP: Show hover documentation and folded code',
      },
    },
  },
  { 'anuvyklack/fold-preview.nvim', dependencies = 'anuvyklack/keymap-amend.nvim', config = true },
}
