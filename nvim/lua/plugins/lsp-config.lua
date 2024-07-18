return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'jay-babu/mason-null-ls.nvim', -- formatter and linter
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
    },

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- cmp use buffer
    'hrsh7th/cmp-path', -- cmp use path
    'hrsh7th/cmp-cmdline', -- command line
    {
      'zbirenbaum/copilot-cmp', -- gh copilot
      event = { 'InsertEnter', 'LspAttach' },
      fix_pairs = true,
      config = function()
        require('copilot_cmp').setup()
      end,
    },
    'saadparwaiz1/cmp_luasnip', -- snippets
    'hrsh7th/cmp-calc',

    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',

    'j-hui/fidget.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspStart', 'LspRestart', 'LspStop', 'LspInfo', 'LspInstall', 'LspUninstall' },
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
        { name = 'copilot', group_index = 2 },
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
            copilot = '[Copilot]',
          },
        },
      },
      window = {
        border = 'rounded',
      },
      completion = {
        border = 'rounded',
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    }

    vim.diagnostic.config {
      update_in_insert = false,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
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
