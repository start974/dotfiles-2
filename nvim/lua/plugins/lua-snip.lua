-----------------------------------------------------------
-- configure snippets
-----------------------------------------------------------

-- Plugin: luasnip
-- url: https://github.com/L3MON4D3/LuaSnip

require("luasnip.loaders.from_lua").load()

require("luasnip.loaders.from_snipmate").load()
require("luasnip").config.setup({store_selection_keys="<Tab>"})
