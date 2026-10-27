-- Diagnostic configuration
vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '󰋼',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
  },
  float = {
    source = 'if_many',
  },
}

-- Display code lenses (refreshed automatically by Neovim)
vim.lsp.codelens.enable(true)

-- Fold with the LSP when the server supports it (treesitter otherwise)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspFold', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

-- ltex-ls-plus (grammar check)
vim.lsp.config('ltex_plus', {
  settings = {
    ltex = {
      language = 'auto',
    },
  },
})

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { '.git' },
})

-- Activ the LSP servers
vim.lsp.enable { 'lua_ls', 'ocamllsp', 'pyright', 'texlab', 'ltex_plus' }
