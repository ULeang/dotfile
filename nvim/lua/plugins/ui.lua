return {
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*",
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
      wk.register({
        ["<leader>"] = {
          b = {
            name = "Buffer Line",
            p = { "<cmd>BufferLineTogglePin<cr>", "Toggle pin" },
            P = { "<cmd>BufferLineGroupClose ungrouped<cr>", "Delete non-pinned" },
            ['1'] = { "<cmd>BufferLineCloseOthers<cr>", "Delete others" },
            l = { "<cmd>BufferLineCloseRight<cr>", "Delete right" },
            h = { "<cmd>BufferLineCloseLeft<cr>", "Delete left" },
            ['0'] = { "<cmd>bdelete<cr>", "Delete" }
          },
        },
        ["H"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev buffer" },
        ["L"] = { "<cmd>BufferLineCycleNext<cr>", "Next buffer" },
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
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {},
  },
  {
    'rcarriga/nvim-notify',
    name = 'notify',
    config = function()
      local ntf = require'notify'
      ntf.setup({
        render = "compact",
      })
      vim.notify = ntf
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          n = {
            name = "notify",
            n = { function()
              require("telescope").extensions.notify.notify()
            end, "Search Notify" },
          }
        }
      })
    end
  },
}
