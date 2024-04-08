local set = vim.o

set.number = true
set.relativenumber = true

set.clipboard = "unnamedplus"

set.autoindent = true
set.smartindent = true

set.cursorline = true

set.ignorecase = true
set.smartcase = true

set.mouse = "a"

set.tabstop = 8
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

set.splitbelow = true
set.splitright = true

set.termguicolors = true

set.wrap = true
set.wrapscan = false

set.signcolumn = "yes:2"

set.showmode = false

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200 })
  end
})
