-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
local opt = vim.o -- Set options (global/buffer/windows-scoped)
-- General settings:
--------------------

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 1000 }
  end,
})

-- Remove whitespace on save
augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = 'TrimWhitespace',
  callback = function()
    local ext = vim.fn.expand '%:e'
    if ext ~= 'trycmd' then
      local view = vim.fn.winsaveview()
      vim.cmd [[keepjumps keeppatterns %s/\s\+$//e]]
      vim.fn.winrestview(view)
    end
  end,
})

-- Don't auto commenting new lines
augroup('NoAutoComment', { clear = true })
autocmd('FileType', {
  group = 'NoAutoComment',
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- auto reload
opt.autoread = true
augroup('AutoReload', { clear = true })
autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
  group = 'AutoReload',
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})

-- Settings for filetypes are in after/ftplugin/
