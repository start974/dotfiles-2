local tabnine = require('tabnine')

tabnine.setup({
  disable_auto_comment=false,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#c58b2c", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"}
})

