return {
  'hrsh7th/nvim-cmp',
  version = false, -- last release is way too old
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- cmp use buffer
    'hrsh7th/cmp-path', -- cmp use path
    'hrsh7th/cmp-cmdline', -- cmp command line
    'hrsh7th/cmp-calc', -- make calulus
    'delphinus/cmp-ctags', -- cmp use ctags
    'kdheepak/cmp-latex-symbols', -- latex symbols

    {
      'zbirenbaum/copilot-cmp', -- gh copilot
      event = { 'InsertEnter', 'LspAttach' },
      fix_pairs = true,
      config = function()
        require('copilot_cmp').setup()
      end,
    },
    'petertriho/cmp-git', -- git
  },
  config = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    local cmp = require 'cmp'

    cmp.setup {
      snippet = {
        expand = function(args)
          require 'snippy'.expand_snippet(args.body)
        end,
      },
      window = {
        border = "rounded",
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      completion = {
        border = "rounded",
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
      },
      sources = cmp.config.sources({
        { name = 'calc' },
        { name = 'copilot', group_index = 2 },
        { name = 'ctags' },
        { name = 'fuzzy_path', keyword_length = 2 },
        { name = 'git' },
        { name = 'greek' },
        { name = 'latex_symbols', option = { strategy = 0,},
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'snippy' }
        },
      }, {
        { name = 'buffer' },
      }),
    }
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      }),
    })
    require('cmp_git').setup()

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
