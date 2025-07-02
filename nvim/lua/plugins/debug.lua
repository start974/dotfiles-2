return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- require for dap ui
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

    -- Configure LLDB adapter
    dap.adapters.lldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'lldb',
        args = { '--port', '${port}' },
        detached = false,
      },
    }

    -- Default debug configuration for rust
    dap.configurations.rust = {
      {
        name = 'Debug an Executable',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,

  keys = {
    {
      '<space>dc',
      function()
        require('dap').continue()
      end,
      mode = 'n',
      desc = 'Debug: Start/Continue',
    },
    {
      '<space>di',
      function()
        require('dap').step_into()
      end,
      mode = 'n',
      desc = 'Debug: Step Into',
    },
    {
      '<space>n',
      function()
        require('dap').step_over()
      end,
      mode = 'n',
      desc = 'Debug: Step Over',
    },
    {
      '<space>o',
      function()
        require('dap').step_out()
      end,
      mode = 'n',
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      mode = 'n',
      desc = 'Debug: Toggle Breakpoint',
    },
  },
}
