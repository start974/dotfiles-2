-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a' -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
opt.encoding = 'UTF-8' -- UTF-8 encodin
opt.winborder = 'rounded' -- Use rounded borders for floating windows

-----------------------------------------------------------
-- Files
-----------------------------------------------------------
opt.swapfile = false -- Don't use swapfile
opt.backup = false -- Don't use backups
opt.undodir = os.getenv 'HOME' .. '/.vim/undodir' -- setup undo files
opt.undofile = true -- undo file active

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
vim.o.foldcolumn = 'auto:9' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
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
opt.relativenumber = false -- relative number
opt.showmatch = true -- Highlight matching parenthesis
opt.colorcolumn = '80' -- Line lenght marker at 80 columns

opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom

opt.linebreak = true -- Wrap on word boundary

opt.termguicolors = true -- Enable 24-bit RGB colors
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
opt.ignorecase = false -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Shift 2 spaces when tab
opt.tabstop = 4 -- 1 tab == 2 spaces
opt.softtabstop = 2 -- shift on edit mod
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append 'sI'

-- -- Disable builtin plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'tutor',
  'rplugin',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  --'ftplugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end
