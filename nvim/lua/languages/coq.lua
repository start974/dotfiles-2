return {
  {
    'whonore/Coqtail',
    init = function()
      vim.cmd [[
        g:coqtail_dune_compile_deps = 1
      ]]
    end,
    cond = function()
      return not vim.g.vscode
    end,
  },
  -- setup lspconfig
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        coq_lsp = {
          cmd = 'coq-lsp',
          filetypes = { 'coq' },
          root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern '_CoqProject' (fname) or util.find_git_ancestor(fname)
          end,
          single_file_support = true,
        },
      },
    },
    keys = {
      {
        '<leader>cR',
        "<cmd>CoqStop<cr><cmd>CoqToLine<cr><cmd>LspRestart<cr>",
        mode = 'n',
        desc = 'Coq Restart',
        noremap = true,
      },
    },
  },
}
