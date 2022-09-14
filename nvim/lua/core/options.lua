-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
--local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis [] {} ()
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline

opt.list = true             -- show whitespace
opt.listchars = {
  nbsp = '⦸',     -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = '»',  -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = '▷─',     -- '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail = '•',    -- BULLET (U+2022, UTF-8: E2 80 A2)
  space = ' ',
}

opt.fillchars = {
  diff = '∙',   -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = ' ',    -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = '·',   -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = '│',   -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
}

-----------------------------------------------------------
--Backup related options
-----------------------------------------------------------
opt.hidden = true     -- Enable background buffers
opt.history = 1000    -- Remember N lines in history
opt.backup = false    -- no make backups before writing
opt.undofile = true   -- persistent undos - undo after you re-open the file
opt.hidden = true     --Hide buffers instead of closing them
opt.autoread = true   -- Reload a file when it is changed from the outside
opt.autowrite = true  -- Write the file when we leave the buffer

-----------------------------------------------------------
-- Search option
-----------------------------------------------------------
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.incsearch = true        -- Move cursor to the matched string

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event
