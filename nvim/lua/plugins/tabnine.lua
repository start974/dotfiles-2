-----------------------------------------------------------
-- Tabnine cmp assistantce for
-----------------------------------------------------------

-- Plugin: tabnine
-- url: https://github.com/tzachar/cmp-tabnines

local tabnine = require('cmp_tabnine.config')

tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
	ignored_file_types = {
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
	show_prediction_strength = false
})

-- prefetch
local prefetch = vim.api.nvim_create_augroup("prefetch", {clear = true})

vim.api.nvim_create_autocmd('BufRead', {
  group = prefetch,
  pattern = '*.py',
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  end
})
