local function get_visual_selection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', ' ')
  if #text > 0 then
    return text
  else
    return ''
  end
end

return {
  {
    'whonore/Coqtail',
    init = function()
      vim.g.loaded_coqtail = 1
      vim.g.coqtail_supported = 1
    end,
  },
  {
    'tomtomjhj/vsrocq.nvim',
    ----dir = '~/Project/vscoq.nvim',
    filetypes = 'coq',
    dependecies = {
      'whonore/Coqtail',
    },
    cond = not vim.g.vscode,
    config = function()
      local vsrocq = require 'vsrocq'
      vsrocq.setup {
        vsrocq = {
          proof = {
            mode = 'Manual', -- Manual, Continuous
            --pointInterpretationMode = 'Cursor', -- NextCommand, Cursor
            cursor = {
              sticky = true,
            },
            diagnostics = true,
            workers = 2,
          },
        },
        lsp = {
          trace = 'message',
          on_attach = function(client, bufnr)
            local vsrocq_client = vsrocq.clients[client.id]
            -- movement in normal mode
            vim.keymap.set({ 'n' }, '<leader>cj', function()
              vsrocq_client:stepForward()
            end, { buffer = bufnr, desc = 'VsRocq step forward' })

            vim.keymap.set({ 'n' }, '<leader>ck', function()
              vsrocq_client:stepBackward()
            end, { buffer = bufnr, desc = 'VsRocq step backward' })

            vim.keymap.set({ 'n' }, '<leader>cl', function()
              vsrocq_client:interpretToPoint()
            end, { buffer = bufnr, desc = 'VsRocq interpret to point' })

            vim.keymap.set({ 'n' }, '<leader>cG', function()
              vsrocq_client:interpretToEnd()
            end, { buffer = bufnr, desc = 'VsRocq interpret to end' })

            -- reset coq
            vim.keymap.set({ 'n' }, '<leader>cR', function()
              vsrocq_client:resetRocq()
            end, { buffer = bufnr, desc = 'VsRocq reset' })

            -- command about
            vim.keymap.set({ 'v' }, '<leader>ca', function()
              vsrocq_client:about(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsRocq about' })

            -- command check
            vim.keymap.set({ 'v' }, '<leader>ch', function()
              vsrocq_client:check(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsRocq check' })

            -- command print
            vim.keymap.set({ 'v' }, '<leader>cp', function()
              vsrocq_client:print(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsRocq print' })

            -- command locate
            vim.keymap.set({ 'v' }, '<leader>cf', function()
              vsrocq_client:locate(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsRocq locate' })

            -- command search
            vim.keymap.set({ 'v' }, '<leader>cs', function()
              vsrocq_client:search(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsRocq search' })
          end,
        },
      }
    end,
  },
}
