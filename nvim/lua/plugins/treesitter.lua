return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    keys = {
      { "<CR>", desc = "Increment Selection" },
      { "<BS>", desc = "Decrement Selection" },
      { "<TAB>", desc = "Increment - Scope" },
    },
    config = function()
      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_config.hypr = {
      --   install_info = {
      --     url = "https://github.com/luckasRanarison/tree-sitter-hyprlang",
      --     files = { "src/parser.c" },
      --     branch = "master",
      --   },
      --   filetype = "hypr",
      -- }
      -- parser_config.nu = {
      --   install_info = {
      --     url = "https://github.com/nushell/tree-sitter-nu",
      --     files = { "src/parser.c" },
      --     branch = "main",
      --   },
      --   filetype = "nu",
      -- }
      require("nvim-treesitter.configs").setup{
        ensure_installed = { "c", "lua", "cpp", "haskell", "bash", "python", "rust", "css",
          "cmake", "json", "markdown", "markdown_inline", "html", "perl", "latex", "hyprlang",
          "nu", "vim", "vimdoc", "diff", "regex", "toml" },

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
      }
    end,
  }
  -- { "luckasRanarison/tree-sitter-hypr" },
  -- {
  --   "luckasRanarison/tree-sitter-hyprlang",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   ft = { "hyprlang" },
  -- }
}
