return {
  'polirritmico/monokai-nightasty.nvim',
  lazy = false,
  priority = 1000,
  keys = {
    {
      '<leader>tt',
      '<Cmd>MonokaiToggleLight<CR>',
      desc = 'Monokai-Nightasty: Toggle dark/light theme.',
    },
  },
  opts = {
    dark_style_background = 'default', -- default, dark, transparent, #color
    light_style_background = 'default', -- default, dark, transparent, #color
    color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
    lualine_bold = true, -- Lualine a and z sections font width
    lualine_style = 'default', -- "dark", "light" or "default" (Follows dark/light style)
    -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
    hl_styles = {
      keywords = { italic = false },
      comments = { italic = true },
    },
    markdown_header_marks = true, -- Add headers marks highlights (the `#` character) to Treesitter highlight query
    on_highlights = function(hl, c)
      local util = require 'monokai-nightasty.util'

      -- Core UI
      hl['@lsp.type.property.lua'] = { fg = c.fg }
      hl.FloatBorder = { fg = c.grey, bg = c.bg_float }
      hl.FloatTitle = { fg = c.magenta, bg = c.bg_float, bold = true }
      hl.StatusLineNC = { fg = c.grey, bg = c.grey_darker }
      -- Closed folds in purple, so they stand out from the background
      hl.Folded = { bg = util.blend(c.purple, c.bg_dark, 0.1), italic = true }
      hl.FoldColumn = { fg = c.purple }

      -- Completion menu (blink.cmp, native popup)
      hl.Pmenu = { fg = c.fg, bg = c.bg_float }
      hl.PmenuSel = { fg = c.magenta, bg = c.bg_highlight, bold = true }
      hl.PmenuExtra = { fg = c.grey, bg = c.bg_float }
      hl.PmenuKind = { fg = c.blue, bg = c.bg_float }
      hl.PmenuBorder = { fg = c.grey, bg = c.bg_float }
      hl.PmenuMatch = { fg = c.yellow, bold = true }
      hl.BlinkCmpMenuBorder = { link = 'PmenuBorder' }
      hl.BlinkCmpDocBorder = { link = 'FloatBorder' }
      hl.BlinkCmpSignatureHelpBorder = { link = 'FloatBorder' }
      hl.BlinkCmpLabelMatch = { fg = c.yellow, bold = true }
      hl.BlinkCmpGhostText = { fg = c.grey, italic = true }

      -- Icons (mini.icons, also used by which-key), mapped on the palette
      hl.MiniIconsAzure = { fg = c.blue }
      hl.MiniIconsBlue = { fg = c.blue_alt }
      hl.MiniIconsCyan = { fg = c.blue }
      hl.MiniIconsGreen = { fg = c.green }
      hl.MiniIconsGrey = { fg = c.grey_light }
      hl.MiniIconsOrange = { fg = c.orange }
      hl.MiniIconsPurple = { fg = c.purple }
      hl.MiniIconsRed = { fg = c.magenta }
      hl.MiniIconsYellow = { fg = c.yellow }

      -- Snacks picker / explorer: monokai colors instead of purple everywhere
      hl.SnacksPickerBorder = { fg = c.grey }
      hl.SnacksPickerTitle = { fg = c.magenta, bold = true }
      hl.SnacksPickerPrompt = { fg = c.magenta }
      hl.SnacksPickerMatch = { fg = c.yellow, bold = true }
      hl.SnacksPickerIcon = { fg = c.blue }
      hl.SnacksPickerSelected = { fg = c.green }
      hl.SnacksPickerToggle =
        { fg = c.blue, bg = util.blend(c.blue, c.bg_dark, 0.15) }
      hl.SnacksPickerDirectory = { fg = c.fg }
      hl.SnacksPickerDir = { fg = c.grey }
      -- Dimmed, but still readable under the cursor line
      hl.SnacksPickerPathHidden = { fg = c.grey }
      hl.SnacksPickerPathIgnored = { fg = c.grey }
      hl.SnacksPickerTotals = { fg = c.grey }
      hl.SnacksPickerUnselected = { fg = c.grey }
      hl.SnacksPickerBufFlags = { fg = c.grey }
      hl.SnacksPickerKeymapRhs = { fg = c.grey }
      hl.SnacksPickerGitStatusUntracked = { fg = c.yellow }
      hl.SnacksPickerTree = { fg = c.grey_medium }

      -- Snacks: indent, dashboard, input, notifier, misc
      hl.SnacksIndentScope = { fg = c.blue }
      hl.SnacksDashboardHeader = { fg = c.blue }
      hl.SnacksDashboardIcon = { fg = c.magenta }
      hl.SnacksDashboardKey = { fg = c.orange, bold = true }
      hl.SnacksDashboardDesc = { fg = c.fg }
      hl.SnacksDashboardFooter = { fg = c.grey, italic = true }
      hl.SnacksDashboardSpecial = { fg = c.yellow }
      hl.SnacksInputBorder = { fg = c.grey }
      hl.SnacksInputTitle = { fg = c.magenta, bold = true }
      hl.SnacksInputIcon = { fg = c.magenta }
      hl.SnacksFooterKey = { fg = c.magenta }
      hl.SnacksFooterDesc = { fg = c.grey }
      hl.SnacksWinKeySep = { fg = c.grey }
      for _, level in ipairs { 'Debug', 'Trace' } do
        for _, part in ipairs { 'Border', 'Icon', 'Title', 'Footer' } do
          hl['SnacksNotifier' .. part .. level] = { fg = c.grey }
        end
      end
      hl.SnacksNotifierHistoryDateTime = { fg = c.grey }

      -- Trouble
      hl.TroubleFilename = { fg = c.fg, bold = true }
      hl.TroubleDirectory = { fg = c.grey }
      hl.TroubleCode = { fg = c.grey }
      hl.TroublePos = { fg = c.grey_medium }
      hl.TroubleIndent = { fg = c.grey_medium }

      -- Neotest: passed green, failed red, in progress / skipped orange
      hl.NeotestPassed = { fg = c.green }
      hl.NeotestFailed = { fg = c.red }
      hl.NeotestRunning = { fg = c.orange }
      hl.NeotestSkipped = { fg = c.orange }
      hl.NeotestWatching = { fg = c.orange }
      hl.NeotestMarked = { fg = c.orange, bold = true }
      hl.NeotestTarget = { fg = c.magenta }
      hl.NeotestAdapterName = { fg = c.magenta, bold = true }
      hl.NeotestNamespace = { fg = c.purple }
      hl.NeotestDir = { fg = c.blue }
      hl.NeotestFile = { fg = c.fg }
      hl.NeotestIndent = { fg = c.grey_medium }
      hl.NeotestExpandMarker = { fg = c.grey_medium }
      hl.NeotestWinSelect = { fg = c.blue, bold = true }

      -- Outline
      hl.OutlineKeymapHelpKey = { fg = c.magenta }
      hl.OutlineStatusProvider = { fg = c.blue }
      hl.OutlineLineno = { fg = c.grey_medium }
    end,
  },
  config = function(_, opts)
    -- Highlight line at the cursor position
    vim.opt.cursorline = true

    -- Default to dark theme
    vim.o.background = 'dark' -- dark | light

    require('monokai-nightasty').load(opts)
  end,
}
