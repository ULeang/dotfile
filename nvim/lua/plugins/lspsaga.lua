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
    wk.add({
      { "<leader>l", group = "Lspsaga" },
      { "<leader>lI", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming Calls" },
      { "<leader>lO", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing Calls" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
      { "<leader>ld", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
      { "<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type Definition" },
      { "<leader>lD", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto Definition" },
      { "<leader>lT", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto Type Definition" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Finder" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
      { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Diagnostic Next" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Diagnostic Prev" },
      { "<C-;>", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },
    })
  end
}
