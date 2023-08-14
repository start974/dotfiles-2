return {
  'kyazdani42/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  config = {
    -- Changes how files within the same directory are sorted.
    sort_by = 'case_sensitive',
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
        'Cargo.toml',
        'Makefile',
        'README.md',
        'readme.md',
        'dune',
        'dune-project',
      },
    },
    -- Configuration for trashing.
    trash = {
      -- The command used to trash items
      cmd = 'trash-put',
    },
    -- actions
    actions = {
      change_dir = {
        -- Change the working directory when changing directories in the tree.
        enable = false,
      },
    },
    -- filter files/ directories
    filters = {
      dotfiles = false,
      custom = { '^.git$' },
    },
  },
  keys = {
    { '<C-n>',     ':NvimTreeToggle<CR>',  desc = 'open/close Tree' },
    { '<leader>f', ':NvimTreeRefresh<CR>', desc = 'Reflesh Tree' },
  },
}
