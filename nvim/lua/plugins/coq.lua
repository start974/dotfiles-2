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
      vim.g['coqtail#supported'] = 0
    end,
  },
  {
    --'tomtomjhj/vscoq.nvim',
    dir = '~/Project/vscoq.nvim',
    filetypes = 'coq',
    dependecies = {
      'whonore/Coqtail',
    },
    config = function()
      local vscoq = require 'vscoq'
      vscoq.setup {
        vscoq = {
          proof = {
            mode = 'Continuous', -- Manual, Continuous
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
            local vscoq_client = vscoq.clients[client.id]
            -- movement in normal mode
            vim.keymap.set({ 'n' }, '<leader>cj', function()
              vscoq_client:stepForward()
            end, { buffer = bufnr, desc = 'VsCoq step forward' })

            vim.keymap.set({ 'n' }, '<leader>ck', function()
              vscoq_client:stepBackward()
            end, { buffer = bufnr, desc = 'VsCoq step backward' })

            vim.keymap.set({ 'n' }, '<leader>cl', function()
              vscoq_client:interpretToPoint()
            end, { buffer = bufnr, desc = 'VsCoq interpret to point' })

            vim.keymap.set({ 'n' }, '<leader>cG', function()
              vscoq_client:interpretToEnd()
            end, { buffer = bufnr, desc = 'VsCoq interpret to end' })

            -- reset coq
            vim.keymap.set({ 'n' }, '<leader>cR', function()
              vscoq_client:resetCoq()
            end, { buffer = bufnr, desc = 'VsCoq reset' })

            -- command about
            vim.keymap.set({ 'v' }, '<leader>ca', function()
              vscoq_client:about(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsCoq about' })

            -- command check
            vim.keymap.set({ 'v' }, '<leader>ch', function()
              vscoq_client:check(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsCoq check' })

            -- command print
            vim.keymap.set({ 'v' }, '<leader>cp', function()
              vscoq_client:print(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsCoq print' })

            -- command locate
            vim.keymap.set({ 'v' }, '<leader>cf', function()
              vscoq_client:locate(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsCoq locate' })

            -- command search
            vim.keymap.set({ 'v' }, '<leader>cs', function()
              vscoq_client:search(get_visual_selection())
            end, { buffer = bufnr, desc = 'VsCoq search' })
          end,
        },
      }
    end,
  },
}
