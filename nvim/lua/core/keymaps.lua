-----------------------------------------------------------
-- General Neovim keymap
-----------------------------------------------------------
local map = vim.keymap.set

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
-- desactive arrow
--for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
  --map('n', key, '<nop>')
--end
-- Clear search highlighting with <leader> and c
map('n', '??', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<leader>p', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<leader>p'

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- move text between line
map('v', "J", ":m '>+1<CR>gv=gv")
map('v', "K", ":m '<-2<CR>gv=gv")

-- move to current line with space
map('n', "J", "mzJ`z")

-- paste withour copy select
map('x', "<leader>p", "\"_dP")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal
---------------------
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- Tagbar
---------------------
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- neofromater
---------------------
map('n', '<C-k>', ':Neoformat<CR>')

-- undo tree
---------------------
map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- formatting
---------------------
map({ "n", "v" }, "<space>f", function()
  vim.lsp.buf.format({ async = true })
end)
