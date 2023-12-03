return {
  "voldikss/vim-floaterm",
  config=function()
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        t = {
          name = "+term option",
          n = { "<cmd>FloatermNew<cr>", "New terminal"},
          t = { "<cmd>FloatermToggle<cr>", "Toggle terminal"},
          h = { "<cmd>FloatermPrev<cr>", "Prev terminal"},
          l = { "<cmd>FloatermNext<cr>", "Next terminal"},
          k = { "<cmd>FloatermKill<cr>", "Kill terminal"},
        }
      }})
    vim.g.floaterm_borderchars="─│─│╭╮╯╰"
  end
}
