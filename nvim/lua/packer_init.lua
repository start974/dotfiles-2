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

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- formating
  use 'sbdchd/neoformat'

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Tag viewer
  use 'preservim/tagbar'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Color schemes
  use 'tanvirtin/monokai.nvim'
  use 'navarasu/onedark.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- LSP
  use "neovim/nvim-lspconfig"

  -- nix
  use 'LnL7/vim-nix'

  -- ocaml
  use 'ocaml/vim-ocaml'
  --use {
    --'$HOME/.nix-profile/share/merlin/vim/',
    --as = 'merlin',
  --}
  --use {
    --'$HOME/.nix-profile/share/ocp-indent/vim/',
    --as = 'ocp-indent',
  --}

  -- Coq
  use 'whonore/Coqtail'

  -- lustre
  use 'vim-scripts/lustre-syntax'

  -- Markdown
  use "ellisonleao/glow.nvim"

  --use {
    --"iamcco/markdown-preview.nvim",
    --run = function() vim.fn["mkdp#util#install"]() end,
  --}

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      {"hrsh7th/cmp-nvim-lua", ft = 'lua'},
      'saadparwaiz1/cmp_luasnip',
    },
  }
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
      require('gitsigns').setup{}
    end
  }

  -- git
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- cheat sheet
  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

