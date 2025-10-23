return {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
}
