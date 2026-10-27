return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = 'ConformInfo',
  keys = {
    {
      '<localleader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
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
      ocaml = { 'ocamlformat', 'ocp-indent', stop_after_first = true },
      python = { 'isort', 'black' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      yaml = { 'prettier' },
      tex = { 'tex-fmt' },
      nix = { 'nixfmt' },
    },
  },
}
