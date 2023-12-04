return {
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust', 'toml', },
    dependencies = {
      'neovim/nvim-lspconfig',
      -- Debugging
      'mfussenegger/nvim-dap',
      'nvim-lua/plenary.nvim',
      "simrat39/symbols-outline.nvim",
    },
    config = function()
      local rt = require("rust-tools")
      rt.setup{
        server = {
          on_attach = function(_, bufnr)
            local wk = require("which-key")
            wk.register({
              ["<leader>a"] = { rt.code_action_group.code_action_group, "Code Action Group - Rust" },
              ["<C-;>"] = { rt.hover_actions.hover_actions, "Hover Action - Rust" },
            }, { buffer = bufnr})
          end,
        },
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
