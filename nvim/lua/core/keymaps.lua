vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opt = {noremap = true,silent = true}

map("n", "<leader>sa", ":w<CR>", opt)
map("i", "jk", "<ESC>", opt)

map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

map("v", "J", ":m '>+1<CR>gv=gv", opt)
map("v", "K", ":m '<-2<CR>gv=gv", opt)

map("n", "<leader>sv", ":vsplit<CR>", opt)
map("n", "<leader>sh", ":split<CR>", opt)

map("n", "<leader>nh", ":nohl<CR>", opt)

-- map("n", "<S-L>", ":bnext<CR>", opt)
-- map("n", "<S-H>", ":bprevious<CR>", opt)
-- map("n", "<C-W>", ":bdelete<CR>", opt)

map("t", "<C-g><C-g>", "<C-\\><C-n>", opt)

map("n","<leader>ft","gg=G``", opt)

map("i", "<C-f>", "<right>", opt)
map("i", "<C-b>", "<left>", opt)
map("i", "<C-n>", "<down>", opt)
map("i", "<C-p>", "<up>", opt)
map("i", "<C-a>", "<home>", opt)
map("i", "<C-e>", "<end>", opt)

map({"n", "i", "v", "x"}, "<C-g>", "<esc>", opt)
