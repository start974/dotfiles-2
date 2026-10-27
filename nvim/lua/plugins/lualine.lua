-- Claude Code status: the session state is written by ~/.claude/statusline.sh
local claude_file = (vim.env.XDG_CACHE_HOME or vim.env.HOME .. '/.cache')
  .. '/claude-code/status.json'
local claude = { mtime = -1, data = {} }

local function claude_connected()
  -- Don't load claudecode.nvim just to draw the statusline
  local cc = package.loaded.claudecode
  return cc ~= nil and cc.is_claude_connected()
end

local function claude_status()
  local cc = package.loaded.claudecode
  if not cc then
    return ''
  end
  if not cc.is_claude_connected() then
    return '󰚩 ○'
  end

  local stat = vim.uv.fs_stat(claude_file)
  if stat and stat.mtime.sec ~= claude.mtime then
    claude.mtime = stat.mtime.sec
    local ok, data = pcall(function()
      return vim.json.decode(table.concat(vim.fn.readfile(claude_file), '\n'))
    end)
    claude.data = ok and data or {}
  end

  local parts = { '󰚩 ●' }
  local ctx = vim.tbl_get(claude.data, 'context_window', 'remaining_percentage')
  if type(ctx) == 'number' then
    table.insert(parts, ('ctx %d%%'):format(math.floor(ctx + 0.5)))
  end
  -- Remaining usage: 5-hour window and week
  for _, limit in ipairs { { 'five_hour', '5h' }, { 'seven_day', '7j' } } do
    local used =
      vim.tbl_get(claude.data, 'rate_limits', limit[1], 'used_percentage')
    if type(used) == 'number' then
      table.insert(
        parts,
        ('%s %d%%'):format(limit[2], math.floor(100 - used + 0.5))
      )
    end
  end
  return table.concat(parts, ' ')
end

-- Names of the LSP servers attached to the current buffer
local function lsp_clients()
  local names = vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.get_clients { bufnr = 0 })
  if #names == 0 then
    return ''
  end
  return ' ' .. table.concat(names, ' ')
end

-- Register being recorded with `q`
local function macro_recording()
  local reg = vim.fn.reg_recording()
  return reg == '' and '' or '󰑋 @' .. reg
end

vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
  group = vim.api.nvim_create_augroup('LualineMacro', { clear = true }),
  callback = function()
    -- reg_recording() is still set during RecordingLeave, refresh right after
    vim.schedule(function()
      local ok, lualine = pcall(require, 'lualine')
      if ok then
        lualine.refresh { place = { 'statusline' } }
      end
    end)
  end,
})

-- Only show encoding / file format when they are not the usual ones
local function unusual_encoding()
  local enc = vim.bo.fileencoding
  return enc ~= '' and enc ~= 'utf-8'
end

local function unusual_fileformat()
  return vim.bo.fileformat ~= 'unix'
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'AndreM222/copilot-lualine' },
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'monokai-nightasty',
      component_separators = '',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'snacks_dashboard' },
      },
      globalstatus = true,
      refresh = {
        statusline = 1000,
      },
    },
    sections = {
      lualine_a = {
        { 'mode', icon = '', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = {
        { 'branch', icon = '' },
        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
      },
      lualine_c = {
        {
          'filetype',
          icon_only = true,
          separator = '',
          padding = { left = 1, right = 0 },
        },
        {
          'filename',
          path = 1, -- relative path
          symbols = {
            modified = '●',
            readonly = '',
            unnamed = '[No Name]',
            newfile = '',
          },
        },
        {
          'diagnostics',
          symbols = { error = ' ', warn = ' ', info = '󰋼 ', hint = '󰌵 ' },
        },
        { macro_recording, color = 'DiagnosticWarn' },
      },
      lualine_x = {
        {
          claude_status,
          color = function()
            return claude_connected() and 'DiagnosticOk' or 'Comment'
          end,
        },
        'copilot',
        { lsp_clients, color = 'Comment' },
        { 'encoding', cond = unusual_encoding },
        { 'fileformat', cond = unusual_fileformat },
      },
      lualine_y = {
        { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
        { 'location', padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        {
          function()
            return ' ' .. os.date '%H:%M'
          end,
          separator = { right = '' },
          left_padding = 2,
        },
      },
    },
    inactive_sections = {
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
    },
    extensions = { 'trouble', 'lazy', 'fugitive', 'nvim-dap-ui', 'quickfix' },
  },
}
