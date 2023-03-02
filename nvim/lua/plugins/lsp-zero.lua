-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url:

local lsp = require('lsp-zero')

-- Give me space
vim.opt.signcolumn = 'yes'

lsp.preset({
  name = 'minimal',
  setup_servers_on_start = true,
  set_lsp_keymaps =  true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- setup lua nvim nvim workspace
lsp.nvim_workspace()

-- change lsp server
lsp.skip_server_setup({'rust_analyzer'})

-- key binding
lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

  bind('n', '<leader>r', vim.lsp.buf.rename, opts)
end)

-- cmp configurations
local cmp = require('cmp')

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = vim.NIL,
    ['<S-Tab>'] = vim.NIL,
  }),
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
})

-- setup lsp
lsp.setup()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp_config = lsp.defaults.cmp_config({
  window = {
    completion = cmp.config.window.bordered()
  }
})

cmp.setup(cmp_config)
-- rust tool integration
require('rust-tools').setup({
  server = lsp.build_options('rust_analyzer', {})
})


-- diagnostic
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
