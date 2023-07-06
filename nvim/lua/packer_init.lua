---------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Install plugins
return require('packer').startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'


  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind.nvim'

  -- tab
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

  -- Tag viewer
  use 'preservim/tagbar'
  use 'delphinus/cmp-ctags' -- ctags

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Color schemes
  use 'tanvirtin/monokai.nvim'
  use 'navarasu/onedark.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }

  -- lsp config
  use { "neovim/nvim-lspconfig" }

  -- mason auto install plugins
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
  }
  -- formation

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'   -- cmp use buffer
  use 'hrsh7th/cmp-path'     -- cmp use path
  use 'hrsh7th/cmp-cmdline'  -- command line
  use 'hrsh7th/cmp-calc'     -- calcultate
  use {
    'tzachar/cmp-tabnine',   -- tabnine (ia)
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }
  use 'saadparwaiz1/cmp_luasnip' -- snippets
  use 'hrsh7th/cmp-nvim-lua'     -- configuration in vim

  -- fuzzy path
  use { 'tzachar/cmp-fuzzy-path', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } } -- auto complete
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  -- nix
  use 'LnL7/vim-nix'

  -- smt-lib2
  use 'bohlender/vim-smt2'

  -- ocaml
  use 'ocaml/vim-ocaml'

  -- Coq
  use 'whonore/Coqtail'

  -- lustre
  use 'vim-scripts/lustre-syntax'

  -- Markdown
  use { "ellisonleao/glow.nvim", config = function()
    require("glow").setup()
  end }

  -- rust
  use 'simrat39/rust-tools.nvim'

  -- undo tree
  use 'mbbill/undotree'

  -- comment
  use 'preservim/nerdcommenter'

  -- Testing
  use 'vim-test/vim-test'

  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {}
    end
  }

  -- git
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- zoxide
  use {
    'jvgrootveld/telescope-zoxide',

    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nanotee/zoxide.vim' },
    }
  }

  -- cheat sheet
  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
