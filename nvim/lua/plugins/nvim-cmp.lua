local cmp = require("cmp")
local luasnip = require('luasnip')
local cmp_map = cmp.mapping
local lspkind = require("lspkind")

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp_map.scroll_docs( -4), -- Up
    ['<C-d>'] = cmp_map.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp_map.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp_map.confirm { select = true, },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }), }),

  sources = {
    { name = "buffer",      keyword_length = 3 },
    { name = "calc" },
    { name = "cmp_tabnine", keyword_length = 5 },
    { name = "ctags" },
    { name = "fuzzy_path",  keyword_length = 2 },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        calc = "[Cacl]",
        cmp_tabnine = "[Tabnine]",
        ctags = "[Tags]",
        fuzzy_path = "[FZPath]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
      })
    })
  },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
  view = {
    entries = { name = 'wildmenu', separator = '|' }
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'fuzzy_path' }
  }, {
    { name = 'cmdline' }
  })
})
