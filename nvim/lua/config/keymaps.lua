-----------------------------------------------------------
-- General Neovim keymap
-----------------------------------------------------------
local map = vim.keymap.set

-- Change leader to a comma, local leader to space
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
-- desactive arrow
--for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
--map('n', key, '<nop>')
--end
-- Clear search highlighting (<C-l> does it too)
map('n', '??', '<Cmd>nohlsearch<CR>', { desc = 'Clear highlighting' })

-- Restart nvim, reopening the current session
map('n', '<leader>r', '<Cmd>restart<CR>', { desc = 'Restart Neovim' })

-- move text between line
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- move to current line with space
map('n', 'J', 'mzJ`z', { desc = 'move current line up with space' })

-- paste without copy select
map('x', '<leader>p', '"_dP', { desc = 'paste without copy select' })

-- split
map('n', '<C-w>-', '<Cmd>split<CR>', { desc = 'horizontal split' })
map('n', '<C-w>|', '<Cmd>vsplit<CR>', { desc = 'vertical split' })

-- Incremental selection, on top of the built-in treesitter `an` / `in`
map('n', '<C-space>', 'van', { remap = true, desc = 'Increment selection' })
map('x', '<C-space>', 'an', { remap = true, desc = 'Increment selection' })
map('x', '<bs>', 'in', { remap = true, desc = 'Decrement selection' })

-- Built-in undotree
map('n', '<leader>u', function()
  vim.cmd.packadd 'nvim.undotree'
  vim.cmd.Undotree()
end, { desc = 'Display undo tree' })
