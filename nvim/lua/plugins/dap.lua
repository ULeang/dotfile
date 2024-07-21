return{
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        "<leader>du",
        function()
          require('dapui').toggle()
        end,
        desc = "Dapui",
      },
    },
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

      require('dapui').setup()
      require("nvim-dap-virtual-text").setup()

      require('which-key').add({
        { "<leader>d", group = "Dap" },
        { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Breakpoint" },
        { "<leader>dc", function() dap.continue() end, desc = "Continue" },
        { "<leader>dr", function() dap.run_last() end, desc = "Run Last" },
        { "<F10>", function() dap.step_over() end,  desc = "Step Over" },
        { "<F11>", function() dap.step_into() end, desc = "Step Into" },
        { "<F12>", function() dap.step_out() end, desc = "Step Out" },
      })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio'
    },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
  }
}
