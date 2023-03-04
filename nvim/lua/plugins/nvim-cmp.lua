local cmp = require("cmp")
local luasnip = require 'luasnip'
local cmp_map = cmp.mapping

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
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),  }),

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "cmp_tabnine", keyword_length = 5 },
    { name = "buffer", keyword_length = 3 },
    { name = "fuzzy_path", keyword_length = 2 },
    { name = "ctags" },
  },
}

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'fuzzy_path' }
  })
})

