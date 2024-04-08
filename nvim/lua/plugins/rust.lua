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
          test_executor = 'background',
          on_initialized = function(health)
            local h = health.health
            if h ~= "ok" then
              vim.notify('rust-analyzer initialized status: '.. h, "warn")
            end
          end,
        },
        server = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable()
            local wk = require("which-key")
            wk.register({
              ["<C-;>"] = { function() vim.cmd.RustLsp { 'hover','actions' } end, "Hover Action - Rust" },
              ["<leader>"] = {
                r = {
                  name = "Rust",
                  a = { function() vim.cmd.RustLsp{'codeAction'} end, "Code Action - Rust" },
                  t = { function() vim.cmd.RustLsp{'testables'} end, "Test" },
                  r = { function() vim.cmd.RustLsp{'runnables'} end, "Run" },
                  d = { function() vim.cmd.RustLsp{'debuggables'} end, "Debug" },
                  M = { function() vim.cmd.RustLsp{'expandMacro'} end, "Expand Macro Recursively" },
                  J = { function() vim.cmd.RustLsp{'moveItem', 'down'} end, "Move Down" },
                  K = { function() vim.cmd.RustLsp{'moveItem', 'up'} end, "Move Up" },
                  E = { function() vim.cmd.RustLsp{'explainError'} end, "Explain" },
                  R = { function() vim.cmd.RustLsp{'renderDiagnostic'} end, "Render Diagnostic" },
                  C = { function() vim.cmd.RustLsp{'openCargo'} end, "Open Cargo" },
                  D = { function() vim.cmd.RustLsp{'openDocs'} end, "Open Docs" },
                  P = { function() vim.cmd.RustLsp{'parentModule'} end, "ParentModule" },
                }
              }
            }, { silent = true, buffer = bufnr })
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
      local opts = { silent = true, mode = "n" }
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          c = {
            name = "Crates",
            v = { cr.show_versions_popup, "Versions" },
            f = { cr.show_features_popup, "Features" },
            u = { cr.update_crate, "Update" },
            a = { cr.update_all_crates, "Update All" },
            U = { cr.upgrade_crate, "Upgrade" },
            A = { cr.upgrade_all_crates, "Upgrade All" },
            H = { cr.open_homepage, "Homepage" },
            R = { cr.open_repository, "Repository" },
            D = { cr.open_documentation, "Documentation" },
            C = { cr.open_crates_io, "Crates Io" },
          }
        }
      }, opts )
    end
  }
}
