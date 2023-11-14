return {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  event = "VeryLazy",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local map = vim.keymap.set
    local opt = {noremap = true,silent = true}
    local builtin = require('telescope.builtin')
    map('n', '<leader>ff', builtin.find_files, opt)
    map('n', '<leader>fg', builtin.live_grep, opt)
    map('n', '<leader>fb', builtin.buffers, opt)
    map('n', '<leader>fh', builtin.help_tags, opt)
    map("n", "<leader>fr", builtin.oldfiles, opt)
  end,
}
