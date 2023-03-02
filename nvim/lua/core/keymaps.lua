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
for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
  map('n', key, '<nop>')
end
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

-- nvim tree
---------------------
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
vim.keymap.set('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- telescope
---------------------
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files)
map('n', '<leader>fg', telescope.live_grep)
map('n', '<leader>fb', telescope.buffers, {})
map('n', '<leader>fh', telescope.help_tags, {})

-- Barbar
---------------------
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Close buffer
map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)

-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- Sort automatically by...
map('n', '<A-b>', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<A-d>', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<A-w>', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
