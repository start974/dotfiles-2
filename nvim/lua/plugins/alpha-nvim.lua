-- Footer
local function footer()
  local version = vim.version()
  local print_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  local datetime = os.date '%Y/%m/%d %H:%M:%S'

  return print_version .. ' ' .. datetime
end

-- Banner
local banner = {
  '                                                    ',
  ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                    ',
}
return {
  'goolord/alpha-nvim',
  cond = not vim.g.vscode,
  config = function()
    local alpha = require 'alpha'

    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = banner

    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
      dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = footer()

    alpha.setup(dashboard.config)
  end,
}
