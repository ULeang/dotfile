return {
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.highlight_unlabeled_phase_one_targets=true
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        -- lua = {'string'},-- it will not add a pair on that treesitter node
      },
      map_c_h = true,
      map_c_w = true,
      ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
    }
  },
  -- {
  --   "numToStr/Comment.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require('Comment').setup()
  --   end
  -- },
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        verilog = {
          "// %s",
          "/* %s */",
        },
        systemverilog = {
          "// %s",
          "/* %s */",
        },
      }
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      vim.opt.list = true,
      vim.opt.listchars:append "eol:󱞥",
      require("ibl").setup()
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        -- blacklist = {'c', 'cpp'},
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      require("todo-comments").setup()
      local wk = require("which-key")
      wk.add({
        { "<leader>t", group = "Todo and Term" },
        { "<leader>td", "<cmd>TodoQuickFix<cr>", desc = "Todo" },
        { "<leader>tf", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev Todo" },
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo" },
      })
    end
  },
}
