return{
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons"
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    triggers = {
      { "<auto>", mode = "nixsotc" },
    },
    -- When it returns true, the popup will be shown only after an additional key is pressed.
    defer = function(ctx)
      if vim.list_contains({ "d", "y" }, ctx.operators) then
        return true
      end
      return vim.list_contains({ "<c-v>", "V" }, ctx.mode)
    end,
    win = {
      border = "double", -- none, single, double, shadow
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = ">", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- disable WhichKey for certain buf types and file types.
    disable = {
      ft = {},
      bt = {},
    },
    debug = false, -- enable wk.log in the current directory
  }
}
