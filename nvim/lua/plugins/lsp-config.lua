-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: mason
-- url: https://github.com/williamboman/mason-lspconfig.nvim
require("mason").setup()
require("mason-lspconfig").setup()


-- Plugin: lsp-config
-- url: https://github.com/neovim/nvim-lspconfig
local vdiag = vim.diagnostic
local map = vim.keymap.set
local fn = vim.fn
-- vim diagnostic
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
map('n', '<space>e', vdiag.open_float, opts)
map('n', '[d', vdiag.goto_prev, opts)
map('n', ']d', vdiag.goto_next, opts)
map('n', '<space>q', vdiag.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local lsp_buff = vim.lsp.buf

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gD', lsp_buff.declaration, bufopts)
  map('n', 'gd', lsp_buff.definition, bufopts)
  map('n', 'K', lsp_buff.hover, bufopts)
  map('n', 'gi', lsp_buff.implementation, bufopts)
  map('n', '<C-k>', lsp_buff.signature_help, bufopts)
  map('n', '<space>wa', lsp_buff.add_workspace_folder, bufopts)
  map('n', '<space>wr', lsp_buff.remove_workspace_folder, bufopts)
  map('n', '<space>wl', function()
    print(vim.inspect(lsp_buff.list_workspace_folders()))
  end, bufopts)
  map('n', '<space>D', lsp_buff.type_definition, bufopts)
  map('n', '<space>r', lsp_buff.rename, bufopts)
  map('n', '<space>ca', lsp_buff.code_action, bufopts)
  map('n', 'gr', lsp_buff.references, bufopts)
  map('n', '<space>f', function() lsp_buff.format { async = true } end, bufopts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_conf = require("lspconfig")

local servers = {
  "pyright", -- Python
  "bashls", -- Bash
  "clangd", -- C / C++
  "cmake", -- CMake
  "jsonls", -- Json
  "lua_ls", -- lua
  "marksman", -- Markdown
  "nil_ls", -- Nix
  "ocamllsp", -- Ocaml
  "taplo" -- Toml
}
for _, name in pairs(servers) do
  lsp_conf[name].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- configure lua with workspace
lsp_conf.lua_ls.setup {
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files,
          -- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
          -- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
          library = {
            fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
            fn.stdpath("config"),
          },
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
      },
    },
    capabilities = capabilities,
  }
