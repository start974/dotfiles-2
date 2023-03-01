-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local status_ok, lsp = pcall(require, 'lsp-zero')
if not status_ok then
  print("cannot configure 'lsp-zero'")
  return
end

-- Give me space
vim.opt.signcolumn = 'yes'

lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.nvim_workspace()

lsp.setup()

-- cmp configurations
--local status_ok, cmp = pcall(require, 'cmp')
--if not status_ok then
  --print("cannot configure 'lsp-zero'")
  --return
--end

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<Tab>'] = vim.NIL,
    ['<S-Tab>'] = vim.NIL,
  })
})

