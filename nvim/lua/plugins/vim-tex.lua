return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  cond = not vim.g.vscode,  -- disable in VSCode
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
}
