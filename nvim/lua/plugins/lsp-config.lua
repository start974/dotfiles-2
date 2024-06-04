return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- cmp use buffer
    'hrsh7th/cmp-path', -- cmp use path
    'hrsh7th/cmp-cmdline', -- command line
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip', -- snippets
    'hrsh7th/cmp-calc',
    'onsails/lspkind.nvim',

    'j-hui/fidget.nvim',
  },

  config = function()
    local cmp = require 'cmp'
    local cmp_lsp = require 'cmp_nvim_lsp'
    local lspkind = require 'lspkind'
    local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    require('fidget').setup {}
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,

        ['lua_ls'] = function()
          local lspconfig = require 'lspconfig'
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = 'Lua 5.1' },
                diagnostics = {
                  globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
                },
              },
            },
          }
        end,
      },
    }

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
      },
      sources = cmp.config.sources {
        { name = 'buffer', keyword_length = 3 },
        { name = 'calc' },
        { name = 'ctags' },
        { name = 'fuzzy_path', keyword_length = 2 },
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
            ctags = '[Tags]',
            fuzzy_path = '[FZPath]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            nvim_lsp = '[LSP]',
          },
        },
      },
      window = {
        border = 'rounded',
      },
      completion = {
        border = 'rounded',
      },
    }

    vim.diagnostic.config {
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    }
  end,
  keys = {
    {
      '<space>f',
      function()
        vim.lsp.buf.format { async = true }
      end,
      mode = { 'n', 'v' },
      desc = 'Lsp format',
    },
  },
}
