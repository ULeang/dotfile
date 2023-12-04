return{
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb',
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${wordspaceFolder}',
          stopOnEntry = false,
          args = {},
        }
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${wordspaceFolder}',
          stopOnEntry = false,
          args = {},

          initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
          end,
          -- ...,
        }
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = "VeryLazy",
    dependencies = 'mfussenegger/nvim-dap',
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
