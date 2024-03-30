return{
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = '/usr/bin/codelldb',
          args = {"--port", "${port}"},
        }
      }
      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${wordspaceFolder}',
          stopOnEntry = false,
        }
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = "VeryLazy",
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio'
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup()
      local dap = require('dap')
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          d = {
            name = "Dap",
            b = { function() dap.toggle_breakpoint() end, "Breakpoint" },
            c = { function() dap.continue() end, "Continue" },
            r = { function() dap.run_last() end, "Run Last" },
            u = { function() dapui.toggle() end, "Dapui" },
          }
        },
        ["<F10>"] = { function() dap.step_over() end, "Step Over" },
        ["<F11>"] = { function() dap.step_into() end, "Step Into" },
        ["<F12>"] = { function() dap.step_out() end, "Step Out" },
      })
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = "VeryLazy",
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }
}
