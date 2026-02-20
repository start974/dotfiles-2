return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true,
  keys = {
    {
      '<C-t>',
      function()
        require('toggleterm').toggle(0)
      end,
      mode = 'n',
      desc = 'Open terminal',
    },
  },
}
