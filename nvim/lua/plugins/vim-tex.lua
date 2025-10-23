return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  cond = not vim.g.vscode,  -- disable in VSCode
}
