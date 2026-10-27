return {
  'coder/claudecode.nvim',
  cond = not vim.g.vscode,
  config = true,
  -- stylua: ignore
  keys = {
    { '<leader>i',  nil,                              desc = 'IA (Claude Code)' },
    { '<leader>ic', '<cmd>ClaudeCode<cr>',            desc = 'Toggle Claude' },
    { '<leader>if', '<cmd>ClaudeCodeFocus<cr>',       desc = 'Focus Claude' },
    { '<leader>ir', '<cmd>ClaudeCode --resume<cr>',   desc = 'Resume Claude' },
    { '<leader>iC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>im', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
    { '<leader>ib', '<cmd>ClaudeCodeAdd %<cr>',       desc = 'Add current buffer' },
    { '<leader>is', '<cmd>ClaudeCodeSend<cr>',        desc = 'Send selection to Claude', mode = 'v' },
    { '<leader>ia', '<cmd>ClaudeCodeDiffAccept<cr>',  desc = 'Accept diff' },
    { '<leader>id', '<cmd>ClaudeCodeDiffDeny<cr>',    desc = 'Deny diff' },
  },
}
