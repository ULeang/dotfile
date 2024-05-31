return {
  {
    "gpanders/nvim-parinfer",
    ft = {"yuck"},
    config = function()
      vim.cmd([[ParinferOn]])
    end
  },
  {
    "elkowar/yuck.vim",
    ft = {"yuck"},
  }
}
