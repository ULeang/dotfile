return {
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup{
        options = {
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              -- highlight = "Directory",
              text_align = "left",
              seperator = true,
            },
          },
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          -- numbers = "buffer_id",
          -- indicator = { style = 'underline' },
          -- hover = {
          --   enabled = true,
          --   delay = 200,
          --   reveal = {'close'}
          -- }
        }
      }
      local wk = require("which-key")
      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
        { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned" },
        { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Delete right" },
        { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete left" },
        { "<leader>b1", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete others" },
        { "<leader>b0", "<cmd>bdelete<cr>", desc = "Delete" },
        { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        { "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        extensions = { "neo-tree", "lazy" },
      })
    end,
  },
}
