return {
  'neovim/nvim-lspconfig',
  cmd = 'LspInfo',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'williamboman/mason.nvim' },
    { 'folke/neodev.nvim' },
  },
  config = function()
    -- This is where all the LSP shenanigans will live

    local lsp = require 'lsp-zero'

    lsp.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp.default_keymaps { buffer = bufnr }
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end,
}
