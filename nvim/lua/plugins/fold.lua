local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'BufReadPost',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
      preview = {
        win_config = {
          border = 'rounded',
          winblend = 0,
        },
      },
      fold_virt_text_handler = handler,
    },
    config = function(opts)
      local language_servers = vim.lsp.get_clients()
      for _, client in ipairs(language_servers) do
        local capabilities = client.server_capabilities or {}
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
        client.server_capabilities.foldingRangeProvider = true
        client.capabilities = vim.tbl_deep_extend('force', client.capabilities, capabilities)
      end

      require('ufo').setup(opts)
    end,
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        mode = 'n',
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        mode = 'n',
        desc = 'Close all folds',
      },
      {
        'K',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor(true)
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        mode = 'n',
        desc = 'LSP: Show hover documentation and folded code',
      },
    },
  },
}
