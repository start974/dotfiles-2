return {
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'BufWinEnter',
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
        group = 'github_copilot',
        callback = function(args)
          vim.fn['copilot#On' .. args.event]()
        end,
      })
      vim.fn['copilot#OnFileType']()
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'fang2hou/blink-copilot',
      'erooke/blink-cmp-latex',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        config = function()
          require('luasnip.loaders.from_snipmate').lazy_load { paths = { '~/.config/nvim/snippets' } }
        end,
      },
    },

    version = '1.*',

    opts = {
      -- active cmdline
      cmdline = { enabled = true },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },

        -- Disable auto brackets
        -- NOTE_: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = false } },

        -- Don't select by default, auto insert on selection
        --list = { selection = { preselect = false, auto_insert = true } },
        -- or set via a function
        --list = { selection = { preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end } },

        menu = {
          -- Don't automatically show the completion menu
          auto_show = true,

          -- nvim-cmp style menu
          --[[        draw = {]]
          --[[columns = {]]
          --[[{ 'label', 'label_description', gap = 1 },]]
          --[[{ 'kind_icon', 'kind' },]]
          --[[text = {]]
          --[[},]]
          --[[},]]
        },

        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },

      -- Use a preset for snippets, check the snippets documentation for more information
      snippets = { preset = 'luasnip' },

      -- Experimental signature help support
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'latex', 'snippets', 'copilot', 'path', 'buffer' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
          latex = {
            name = 'Latex',
            module = 'blink-cmp-latex',
            opts = {
              -- set to true to insert the latex command instead of the symbol
              insert_command = false,
            },
          },
        },
      },
    },
  },
}
