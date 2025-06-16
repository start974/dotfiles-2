return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'jubnzv/virtual-types.nvim', -- virtual type for ocaml
    'mason.nvim',
    { 'williamboman/mason-lspconfig.nvim', config = function() end },
  },
  config = function()
    local lsp = require 'lspconfig'

    -- capabielities
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- config lsp sign
    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = '',
      })
    end

    -- diagnostic
    vim.diagnostic.config {
      virtual_text = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = '󰋼 ',
          [vim.diagnostic.severity.HINT] = '󰌵 ',
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = 'Error',
          [vim.diagnostic.severity.WARN] = 'Error',
          [vim.diagnostic.severity.HINT] = 'Hint',
          [vim.diagnostic.severity.INFO] = 'Info',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },

      float = {
        border = 'rounded',
        -- source = 'always',
      },
    }

    -- handelers
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

    -- mason
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- lua
    lsp.lua_ls.setup {
      on_init = function(client)
        local join = vim.fs.joinpath

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        -- Apply neovim specific settings
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, join('lua', '?.lua'))
        table.insert(runtime_path, join('lua', '?', 'init.lua'))

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.stdpath 'config',
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            --library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      settings = {
        Lua = {},
      },
    }
    -- coq
    --lsp.coq_lsp.setup {
    --capabilities = capabilities,
    --}

    -- ocaml
    -- (TODO: try early bird dap)
    lsp.ocamllsp.setup {
      capabilities = capabilities,
      on_attach = require('virtualtypes').on_attach,
    }
  end,
}
