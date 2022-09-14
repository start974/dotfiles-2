-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  desc = "highlight text on yank",
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = '500'
    })
  end
})

-- Buffer group
augroup('Buffer', { clear = true })
-- Remove whitespace on save
autocmd('BufWritePre', {
  desc = "remove whitespaces on save",
  group = 'Buffer',
  pattern = '*',
  command = ':%s/\\s\\+$//e',
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
  desc = "Don't auto commenting new lines",
  group = 'Buffer',
  pattern = '*',
  command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
})

--jump to last posistion when reopening file
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Jump to the last position when reopening a file",
  group = 'Buffer',
  pattern = "*",
  command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
})

-- Settings for filetypes:
-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  desc = "Disable line length marker";
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  desc = "Set indentation to 2";
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua', 'nix'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- quit with q on help pages
vim.api.nvim_create_autocmd("FileType", {
  desc = "Quit with q on help pages";
  pattern = { "man", "help", "lspinfo", "null-ls-info", "lsp-installer" },
  command = "nnoremap <silent> <buffer> <leader>q :close<CR>",
})

--vim.api.nvim_create_autocmd("VimResized", {
--  desc = "auto resize splited windows",
--  pattern = "*",
--  group = group,
--  command = "tabdo wincmd =",
--})



-- Terminal settings:
augroup('Terminal', { clear = true })
-- Open a Terminal on the down tab
autocmd('CmdlineEnter', {
  desc = "Open a Terminal on the down tab",
  group = 'Terminal',
  command = 'command! Term :botright split term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  desc = 'no number in terminal',
  group = 'Terminal',
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  desc = 'Enter insert mode in terminal enter',
  group = 'Terminal',
  pattern = '*',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  desc = "Close terminal buffer",
  group = 'Terminal',
  pattern = 'term://*',
  command = 'stopinsert'
})

