return {
  'tomtomjhj/vscoq.nvim',
  dependencies = {
    'whonore/Coqtail',
    'neovim/nvim-lspconfig',
  },
  init = function()
    --vim.g.loaded_coqtail = 1
    --vim.g.coqtail_supported = 0
  end,
  opts = {
    vscoq = {
      proof = {
        mode = 1,
      },
    },
    lsp = {
      autostart = true,
    },
  },
}
