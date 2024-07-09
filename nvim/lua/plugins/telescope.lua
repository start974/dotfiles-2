local function getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    -- search file
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files()
      end,
      mode = 'n',
      desc = '[F]ind [F]ile',
    },
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files { default_text = getVisualSelection() }
      end,
      mode = 'v',
      desc = '[F]ind [F]ile (visual)',
    },
    -- live grep
    {
      '<leader>fg',
      function()
        require('telescope.builtin').live_grep()
      end,
      mode = 'n',
      desc = '[F]ind [G]rep',
    },
    {
      '<leader>fg',
      function()
        require('telescope.builtin').live_grep { default_text = getVisualSelection() }
      end,
      mode = 'v',
      desc = '[F]ind [G]rep (visual)',
    },
    -- help
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = '[S]earch [H]elp',
    },
    -- diagnostic
    {
      '<leader>sd',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    -- keys
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch [D]keys',
    },
  },
  cond = function()
    return not vim.g.vscode
  end,
}
