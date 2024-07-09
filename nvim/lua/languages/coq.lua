return {
  {
    'whonore/Coqtail',
    cond = function()
      return not vim.g.vscode
    end,
  },
  --{
  --'tomtomjhj/vscoq.nvim',
  --dependencies = {
  --'whonore/Coqtail',
  --'neovim/nvim-lspconfig',
  --},
  --config = function()
  --vim.g.coqtail_nomap = 1
  --vim.g.loaded_coqtail = 1
  --vim.g.coqtail_supported = 0

  --require('vscoq').setup {}
  ----vscoq = {
  ----proof = {
  ----mode = 0,
  ------sticky = false,
  ------workers = 4,
  ----},
  ----},
  ------completion = {
  ------enable = true,
  ------},
  ----lsp = {
  ----autostart = true,
  ----},
  ----}
  --end,

  --keys = {
  --{
  --'<leader>cj',
  --'<Cmd>VsCoq stepForward<CR>',
  --mode = 'n',
  --desc = '[Coq] Interpret Forward in proof',
  --},
  --{
  --'<leader>ck',
  --'<Cmd>VsCoq stepBackward<CR>',
  --mode = 'n',
  --desc = '[Coq] Interpret Backward in proof',
  --},
  --{
  --'<leader>cG',
  --'<Cmd>VsCoq interpretToEnd<CR>',
  --mode = 'n',
  --desc = '[Coq] Interpret to end',
  --},
  --{
  --'<leader>cp',
  --'<Cmd>VsCoq interpretToPoint<CR>',
  --mode = 'n',
  --desc = '[Coq] Interpret to point',
  --},
  --},
  --cond = function()
  --return not vim.g.vscode
  --end,
  --},
}
