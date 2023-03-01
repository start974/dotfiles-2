local status_ok, telescope = pcall(require, 'telescope.builtin')
if not status_ok then
  print("cannot configure 'telescope'")
  return
end

-- mapping
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
