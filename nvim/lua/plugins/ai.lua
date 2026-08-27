return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }
  end,
  keys = {
    {
      '<C-a>',
      function()
        require('opencode').ask '@this: '
      end,
      mode = { 'n', 'x' },
      { desc = 'Ask OpenCode…' },
    },
    {
      '<C-x>',
      function()
        require('opencode').select()
      end,
      mode = { 'n', 'x' },
      { desc = 'Select OpenCode…' },
    },
    {
      'go',
      function()
        return require('opencode').operator '@this '
      end,
      mode = { 'n', 'x' },
      { desc = 'Append range to OpenCode', expr = true },
    },
    {
      'goo',
      function()
        return require('opencode').operator '@this ' .. '_'
      end,
      mode = { 'n' },
      { desc = 'Append line to OpenCode', expr = true },
    },
    {
      '<S-C-u>',
      function()
        require('opencode').command 'session.half.page.up'
      end,
      mode = { 'n' },
      { desc = 'Scroll OpenCode up' },
    },
    {
      '<S-C-d>',
      function()
        require('opencode').command 'session.half.page.down'
      end,
      mode = { 'n' },
      { desc = 'Scroll OpenCode down' },
    },
  },
}
