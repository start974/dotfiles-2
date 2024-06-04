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
map('n', '??', ':nohl<CR>', { desc = 'Clear highlighting' })

-- Toggle auto-indenting for code paste
map('n', '<leader>p', ':set invpaste paste?<CR>', { desc = 'Auto indenting code paste' })
-- vim.opt.pastetoggle = '<leader>p'

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>', { desc = 'Reload configuration' })

-- move text between line
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line up' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line down' })

-- move to current line with space
map('n', 'J', 'mzJ`z', { desc = 'move current line up with space' })

-- paste without copy select
map('x', '<leader>p', '"_dP', { desc = 'paste without copy select' })

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal
---------------------
map('n', '<C-t>', ':Term<CR>', { noremap = true, desc = 'Open terminal' }) -- open
map('t', '<Esc>', '<C-\\><C-n>') -- exit
