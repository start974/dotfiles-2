-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- url: https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `core/keymaps.lua`:
-- https://github.com/kyazdani42/nvim-tree.lua#keybindings
local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  -- Changes how files within the same directory are sorted.
  sort_by = "case_sensitive",
  -- Keeps the cursor on the first letter of the filename when moving in the tree.
  hijack_cursor = true,
  -- Show LSP diagnostics in the signcolumn
  diagnostics = {
    enable = true,
  },
  -- Update the focused file on `BufEnter`
  update_focused_file = {
    enable = true,
  },

  -- ui redering
  renderer = {
    -- A list of filenames that gets highlighted with `NvimTreeSpecialFile`
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "dune",
      "dune-project",
    }
  },
  -- Configuration for trashing.
  trash = {
    -- The command used to trash items
    cmd = "trash-put"
  },
  -- actions
  actions = {
    change_dir = {
      -- Change the working directory when changing directories in the tree.
      enable = false;

    }
  },
  -- filter files/ directories
  filters = {
    dotfiles = false,
    custom = { '^.git$' }
  }
})


-- Open For Directories And Change Neovim's Directory
local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-- map
---------------------
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
vim.keymap.set('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file
