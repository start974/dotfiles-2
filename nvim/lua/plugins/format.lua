return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = true,
  cmd = 'ConformInfo',
  keys = {
    {
      '<space>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = { 'n' },
      desc = 'Format File',
    },
  },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = 'fallback', -- not recommended to change
    },
    formatters_by_ft = {
      json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      ocaml = { 'ocamlformat', 'ocp-indent' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      yaml = { 'prettier' },
    },
  },
}
