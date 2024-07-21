return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },

    config = function()
      local M = {
        execute_command = function(command, args, cwd, _)
          local shell = require('rustaceanvim.shell')
          local commands = {}
          if cwd then
            table.insert(commands, shell.make_cd_command(cwd))
          end
          table.insert(commands, shell.make_command_from_args(command, args))
          local full_command = shell.chain_commands(commands)
          vim.cmd([[FloatermNew --autoclose=0 ]] .. full_command)
        end
      }
      vim.g.rustaceanvim = {
        tools = {
          executor = M,
          test_executor = M,
          -- test_executor = 'background',
          on_initialized = function(health)
            local h = health.health
            if h ~= "ok" then
              vim.notify('rust-analyzer initialized status: '.. h, "warn")
            end
          end,
        },
        server = {
          on_attach = function(_, bufnr)
            -- vim.lsp.inlay_hint.enable()
            local wk = require("which-key")
            wk.add({
              {
                buffer = bufnr,
                { "<C-;>", function() vim.cmd.RustLsp { 'hover','actions' } end, desc = "Hover Action - Rust" },
                { "<leader>r", group = "Rust" },
                { "<leader>ra", function() vim.cmd.RustLsp{'codeAction'} end, desc = "Code Action - Rust" },
                { "<leader>rt", function() vim.cmd.RustLsp{'testables'} end, desc = "Test" },
                { "<leader>rr", function() vim.cmd.RustLsp{'runnables'} end, desc = "Run" },
                { "<leader>rd", function() vim.cmd.RustLsp{'debuggables'} end, desc = "Debug" },
                { "<leader>rM", function() vim.cmd.RustLsp{'expandMacro'} end, desc = "Expand Macro Recursively" },
                { "<leader>rJ", function() vim.cmd.RustLsp{'moveItem', 'down'} end, desc = "Move Down" },
                { "<leader>rK", function() vim.cmd.RustLsp{'moveItem', 'up'} end, desc = "Move Up" },
                { "<leader>rE", function() vim.cmd.RustLsp{'explainError'} end, desc = "Explain" },
                { "<leader>rR", function() vim.cmd.RustLsp{'renderDiagnostic'} end, desc = "Render Diagnostic" },
                { "<leader>rC", function() vim.cmd.RustLsp{'openCargo'} end, desc = "Open Cargo" },
                { "<leader>rD", function() vim.cmd.RustLsp{'openDocs'} end, desc = "Open Docs" },
                { "<leader>rP", function() vim.cmd.RustLsp{'parentModule'} end, desc = "ParentModule" },
              }
            })
          end,
        }
      }
    end
  },
  {
    "saecki/crates.nvim",
    tag = 'stable',
    dependencies = 'nvim-lua/plenary.nvim',
    ft = { 'toml' },
    config = function()
      local cr = require("crates")
      cr.setup()
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "Crates" },
        { "<leader>cv", cr.show_versions_popup, desc = "Versions" },
        { "<leader>cf", cr.show_features_popup, desc = "Features" },
        { "<leader>cu", cr.update_crate, desc = "Update" },
        { "<leader>ca", cr.update_all_crates, desc = "Update All" },
        { "<leader>cU", cr.upgrade_crate, desc = "Upgrade" },
        { "<leader>cA", cr.upgrade_all_crates, desc = "Upgrade All" },
        { "<leader>cH", cr.open_homepage, desc = "Homepage" },
        { "<leader>cR", cr.open_repository, desc = "Repository" },
        { "<leader>cD", cr.open_documentation, desc = "Documentation" },
        { "<leader>cC", cr.open_crates_io, desc = "Crates Io" },
      })
    end
  }
}
