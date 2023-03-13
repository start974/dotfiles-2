
local telescope = require('telescope.builtin')
local map = vim.keymap.set

local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local function map_normal_visual(key, telescope_finder)
  map('n', key, telescope_finder)
  map('v', key, function ()
	  local text = getVisualSelection()
    telescope_finder({ default_text = text })
  end)
end

-- mapping
map_normal_visual('<leader>ff', telescope.find_files)
map_normal_visual('<leader>fg', telescope.live_grep)
map_normal_visual('<leader>fb', telescope.buffers)
map_normal_visual('<leader>fh', telescope.help_tags)
