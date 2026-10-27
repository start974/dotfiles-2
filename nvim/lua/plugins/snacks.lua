-- Footer
local function footer()
  local version = vim.version()
  local print_version = 'v'
    .. version.major
    .. '.'
    .. version.minor
    .. '.'
    .. version.patch
  local datetime = os.date '%Y/%m/%d %H:%M:%S'

  return print_version .. ' ' .. datetime
end

-- Banner
local banner = {
  ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
}

-- Text selected in visual mode, on a single line
local function visual_selection()
  local lines = vim.fn.getregion(
    vim.fn.getpos 'v',
    vim.fn.getpos '.',
    { type = vim.fn.mode() }
  )
  return table.concat(lines, '')
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  cond = not vim.g.vscode,
  dependencies = {
    -- File type icons in the explorer and pickers
    {
      'nvim-mini/mini.icons',
      opts = {},
      init = function()
        -- Plugins requiring nvim-web-devicons get mini.icons instead
        package.preload['nvim-web-devicons'] = function()
          require('mini.icons').mock_nvim_web_devicons()
          return package.loaded['nvim-web-devicons']
        end
      end,
    },
  },
  opts = {
    -- Start screen
    dashboard = {
      preset = {
        header = table.concat(banner, '\n'),
        -- stylua: ignore
        keys = {
          { icon = '\u{f016} ', key = 'e', desc = 'New file',       action = ':ene | startinsert' },
          { icon = '\u{f0c5} ', key = 'r', desc = 'Recent',         action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '\u{f15c} ', key = 'f', desc = 'Find file',      action = ":lua Snacks.dashboard.pick('files')" },
          { icon = '\u{f185} ', key = 's', desc = 'Settings',       action = ':e $MYVIMRC' },
          { icon = '\u{f113} ', key = 'u', desc = 'Update plugins', action = ':Lazy update' },
          { icon = '\u{f057} ', key = 'q', desc = 'Quit',           action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { text = { footer(), hl = 'SnacksDashboardFooter' }, align = 'center' },
      },
    },
    -- File explorer (replaces netrw)
    explorer = { trash = true },
    -- Indent guides, current scope highlighted in a single color
    indent = {},
    picker = {
      -- Search bar at the bottom, results above it (telescope style)
      layout = { preset = 'telescope' },
      -- Icons shown in the search bar title when an option is on
      toggles = {
        follow = '\u{f0c1}', -- follow symlinks
        hidden = '\u{f070}', -- hidden files
        ignored = '\u{f05e}', -- gitignored files
        modified = '\u{f040}', -- modified buffers
        regex = { icon = '\u{f069}', value = false }, -- literal search (regex off)
      },
      sources = {
        explorer = {
          hidden = true,
          exclude = { '.git' },
        },
      },
    },
    terminal = {},
    -- Prettier notifications, with a history
    notifier = {},
    -- Floating window for vim.ui.input (LSP rename, ...)
    input = {},
    -- Highlight references of the word under the cursor
    words = {},
    -- Disable heavy features (treesitter, LSP, ...) on big files
    bigfile = {},
    -- Aligned git signs, diagnostics and folds (to try out)
    statuscolumn = {},
  },
  -- stylua: ignore
  keys = {
    -- explorer
    { '<C-n>',      function() Snacks.explorer() end,                                     desc = 'open/close Tree' },
    -- search file
    { '<leader>ff', function() Snacks.picker.files() end,                                 desc = '[F]ind [F]ile' },
    { '<leader>ff', function() Snacks.picker.files { pattern = visual_selection() } end,  desc = '[F]ind [F]ile (visual)', mode = 'x' },
    -- live grep
    { '<leader>fg', function() Snacks.picker.grep() end,                                  desc = '[F]ind [G]rep' },
    { '<leader>fg', function() Snacks.picker.grep_word() end,                             desc = '[F]ind [G]rep (visual)', mode = 'x' },
    -- help, diagnostics, keys
    { '<leader>sh', function() Snacks.picker.help() end,                                  desc = '[S]earch [H]elp' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end,                           desc = '[S]earch [D]iagnostics' },
    { '<leader>sk', function() Snacks.picker.keymaps() end,                               desc = '[S]earch [K]eys' },
    -- terminal
    { '<C-t>',      function() Snacks.terminal.toggle() end,                              desc = 'Open terminal' },
    -- notifications
    { '<leader>n',  function() Snacks.picker.notifications() end,                         desc = '[N]otification history' },
    -- jump between references of the word under the cursor
    { ']]',         function() Snacks.words.jump(vim.v.count1) end,                       desc = 'Next reference', mode = { 'n', 't' } },
    { '[[',         function() Snacks.words.jump(-vim.v.count1) end,                      desc = 'Prev reference', mode = { 'n', 't' } },
    -- close buffer, keeping the window layout
    { '<A-w>',      function() Snacks.bufdelete() end,                                    desc = 'Close buffer' },
    -- rename current file, updating imports through the LSP
    { '<leader>fR', function() Snacks.rename.rename_file() end,                           desc = '[F]ile [R]ename' },
  },
}
