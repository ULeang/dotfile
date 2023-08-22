return {
  "nvim-treesitter/nvim-treesitter",
  -- dependencies = "HiPhish/nvim-ts-rainbow2",
  config = function()
    require("nvim-treesitter.configs").setup{
      ensure_installed = { "c", "lua", "cpp", "haskell", "bash", "python", "rust", "css", "cmake", "json", "markdown", "markdown_inline", "html", "perl"},

      highlight = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = '<TAB>',
        }
      },
      -- treesitter based code formatting (=)
      indent = { enable = true },

      -- rainbow = {
      --   enable = true,
      --   -- list of languages you want to disable the plugin for
      --   -- disable = { 'jsx', 'cpp' },
      --   -- Which query to use for finding delimiters
      --   query = 'rainbow-parens',
      --   -- Highlight the entire buffer all at once
      --   strategy = require('ts-rainbow').strategy.global,
      --   hlgroups = {
      --     'TSRainbowBlue',
      --     'TSRainbowYellow',
      --     'TSRainbowOrange',
      --     'TSRainbowGreen',
      --     'TSRainbowViolet',
      --     'TSRainbowCyan',
      --     'TSRainbowRed',
      --   }
      -- },
    }
  end,
}
