return {
  'whonore/Coqtail',
  ft = 'coq',
  init = function()
    vim.cmd [[
        g:coqtail_dune_compile_deps = 1
    ]]
  end,
  keys = {
    {
      '<leader>cR',
      '<cmd>CoqStop<cr><cmd>LspRestart<cr><cmd>CoqToLine<cr>',
      mode = 'n',
      desc = 'Coq Restart',
      noremap = true,
    },
  },
}
