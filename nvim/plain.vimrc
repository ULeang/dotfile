set number
set relativenumber

set clipboard=unnamedplus

set autoindent
set smartindent

set cursorline

set ignorecase
set smartcase

set mouse=a

set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

set splitbelow
set splitright

set termguicolors

set wrap
set nowrapscan

set signcolumn=auto:1-3

set noshowmode

let g:mapleader=" "
let g:maplocalleader=" "

nnoremap <silent> <leader>sa :w<cr>
inoremap jk <esc>

vnoremap <silent> J :m '>+1<cr>gv=gv
vnoremap <silent> K :m '<-2<cr>gv=gv

nnoremap <silent> <leader>sv :vsplit<cr>
nnoremap <silent> <leader>sh :split<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>nh :nohl<cr>

nnoremap <silent> <S-L> :bnext<cr>
nnoremap <silent> <S-H> :bprevious<cr>
nnoremap <silent> <leader>bd :bdelete<cr>

tnoremap <C-n><C-n> <C-\\><C-n>

nnoremap <leader>gg gg=Gzz
