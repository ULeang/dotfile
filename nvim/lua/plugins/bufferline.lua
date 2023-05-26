return {
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
            highlight = "Directory",
            text_align = "left",
          },
        },
        separator_style = "slant",
        diagnostics = "nvim_lsp",
      }
    }
  end,
}
