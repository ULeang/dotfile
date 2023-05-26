return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup{
      ensure_installed = { "c", "lua", "cpp", "haskell", "bash", "python", "rust", "javascript",
      "css", "cmake", "json", "markdown", "markdown_inline", "html", "regex"},

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
