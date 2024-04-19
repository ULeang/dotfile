return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'     -- optional
  },
  config = function()
    require('lspsaga').setup({
      ui = {
        code_action = '󱠀 '
      }
    })
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        l = {
          name = "Lsp",
          I = { "<cmd>Lspsaga incomming_calls<cr>", "Incomming Calls" },
          O = { "<cmd>Lspsaga outgoing_calls<cr>", "Outgoing Calls" },
          a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
          d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
          t = { "<cmd>Lspsaga peek_type_definition<cr>", "Peek Type Definition" },
          D = { "<cmd>Lspsaga goto_definition<cr>", "Goto Definition" },
          T = { "<cmd>Lspsaga goto_type_definition<cr>", "Goto Type Definition" },
          f = { "<cmd>Lspsaga finder<cr>", "Finder" },
          o = { "<cmd>Lspsaga outline<cr>", "Outline" }
        },
        ["rn"] = { "<cmd>Lspsaga rename<cr>", "Rename" }
      },
      ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Diagnostic Next" },
      ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Diagnostic Prev" },
      ["<C-;>"] = { "<cmd>Lspsaga hover_doc<cr>", "Hover" },
    })
  end
}
