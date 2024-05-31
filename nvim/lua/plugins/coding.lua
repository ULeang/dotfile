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
    event = "VeryLazy",
    config = function()
      require("nvim-autopairs").setup {}
    end
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
      wk.register({
        ["<leader>t"] = {
          d = { "<cmd>TodoQuickFix<cr>", "Todo" },
          f = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
        },
        ["[t"] = {
          function()
            require("todo-comments").jump_prev()
          end, "Prev Todo"
        },
        ["]t"] = {
          function()
            require("todo-comments").jump_next()
          end, "Next Todo"
        },
      })
    end
  },
}
