return {
  'nvim-neotest/neotest',
  main = 'neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'mrcjkb/rustaceanvim', -- adapter Rust intégré
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'rustaceanvim.neotest',
      },
    }
  end,
}
