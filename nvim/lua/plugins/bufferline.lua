return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  event = 'VeryLazy',
  lazy = false,
  config = {
    options = {
      numbers = 'ordinals',
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'center',
          separator = true,
        },
      },
      get_element_icon = function(element)
        -- element consists of {filetype: string, path: string, extension: string, directory: string}
        -- This can be used to change how bufferline fetches the icon
        -- for an element e.g. a buffer or a tab.
        -- e.g.
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
        -- or
      end,
    },
  },
  keys = {
    -- Move to previous/next
    { '<A-,>', '<Cmd>BufferLineCyclePrev<CR>',     desc = 'Next Tab' },
    { '<A-.>', '<Cmd>BufferLineCycleNext<CR>',     desc = 'Prev Tab' },
    -- Re-order to previous/next
    { '<A-<>', '<Cmd>BufferLineMovePrev<CR>',      desc = 'Move to prev Tab' },
    { '<A->>', '<Cmd>BufferLineMoveNext<CR>',      desc = 'Move to next Tab' },
    -- Goto buffer in position...
    { '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>',  desc = 'GoTo Tab 1' },
    { '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>',  desc = 'GoTo Tab 2' },
    { '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>',  desc = 'GoTo Tab 3' },
    { '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>',  desc = 'GoTo Tab 4' },
    { '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>',  desc = 'GoTo Tab 5' },
    { '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>',  desc = 'GoTo Tab 6' },
    { '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>',  desc = 'GoTo Tab 7' },
    { '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>',  desc = 'GoTo Tab 8' },
    { '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>',  desc = 'GoTo Tab 9' },
    { '<A-9>', '<Cmd>BufferLineGoToBuffer 10<CR>', desc = 'GoTo Tab 10' },
    -- Pin/unpin buffer
    { '<A-p>', '<Cmd>BufferLineTogglePin<CR>',     desc = '[P]in Tab' },
  },
}
