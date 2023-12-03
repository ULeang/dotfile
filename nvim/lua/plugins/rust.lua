return {
  'simrat39/rust-tools.nvim',
  dependencies = {
    -- Debugging
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
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
            ["<C-h>"] = { rt.hover_actions.hover_actions, "Hover Action - Rust" },
          }, { buffer = bufnr})
        end,
      },
    }
  end
}
