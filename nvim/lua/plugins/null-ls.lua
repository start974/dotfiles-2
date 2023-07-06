-----------------------------------------------------------
-- Neovim formating configuration
-----------------------------------------------------------

-- Plugin: null-ls
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

-- Plugin: mason-null-ls
-- url: https://github.com/jay-babu/mason-null-ls.nvim

require("mason").setup()
require("mason-null-ls").setup({
	ensure_installed = {
		-- Opt to list sources here, when available in mason.
	},
	automatic_installation = false,
	handlers = {},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {},
})
