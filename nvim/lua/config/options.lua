-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- Providers
-----------------------------------------------------------
g.loaded_perl_provider = 0 -- Disable Perl provider
g.loaded_python3_provider = 0 -- Disable Python provider
g.loaded_node_provider = 0 -- Disable Node provider
g.loaded_ruby_provider = 0 -- Disable Ruby provider

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a' -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
opt.winborder = 'rounded' -- Use rounded borders for floating windows

-----------------------------------------------------------
-- Files
-----------------------------------------------------------
opt.swapfile = false -- Don't use swapfile
opt.backup = false -- Don't use backups
opt.undofile = true -- undo file active

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
vim.o.foldcolumn = 'auto:9'
vim.o.foldlevel = 99 -- Open all folds by default
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'indent' -- fallback, treesitter / LSP folds are set per buffer
vim.o.foldtext = '' -- keep syntax highlighting on the folded line
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = '│',
}

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.signcolumn = 'yes' -- Always show the sign column, avoids text shifting
opt.relativenumber = false -- relative number
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = '80' -- Line lenght marker at 80 columns

opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom

opt.linebreak = true -- Wrap on word boundary

opt.laststatus = 3 -- Set global statusline

opt.wrap = true -- active text vrapping
opt.scrolloff = 5 -- scrolling if 5 line

opt.list = true -- display list char
opt.lcs = {
  eol = '↴',
  --space = '⋅',
  tab = '>-',
  extends = '◀',
  precedes = '▶',
}

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.hlsearch = true -- keep highlight search
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Shift 2 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.softtabstop = 2 -- shift on edit mod

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append 'sI'
