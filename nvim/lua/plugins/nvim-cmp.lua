return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      config = function()
        --require("luasnip.loaders.from_lua").load()
        require('luasnip.loaders.from_snipmate').load()
        require('luasnip').config.setup()
      end,
    },
    'saadparwaiz1/cmp_luasnip', -- snippets
    'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer',       -- cmp use buffer
    'hrsh7th/cmp-path',         -- cmp use path
    'hrsh7th/cmp-cmdline',      -- command line
    'hrsh7th/cmp-calc',
    'onsails/lspkind.nvim',
    'VonHeikemen/lsp-zero.nvim',
  },
  config = function()
    -- Here is where you configure the autocompletion settings.
    -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

    require('lsp-zero.cmp').extend()

    -- And you can configure cmp even more, if you want to.
    local cmp = require 'cmp'
    local cmp_action = require('lsp-zero.cmp').action()
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    cmp.setup {
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = 'buffer',      keyword_length = 3 },
        { name = 'calc' },
        { name = 'cmp_tabnine', keyword_length = 5 },
        { name = 'ctags' },
        { name = 'fuzzy_path',  keyword_length = 2 },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
      },

      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          menu = {
            buffer = '[Buffer]',
            calc = '[Cacl]',
            cmp_tabnine = '[Tabnine]',
            ctags = '[Tags]',
            fuzzy_path = '[FZPath]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            nvim_lsp = '[LSP]',
          },
        },
      },
    }
  end,
}
