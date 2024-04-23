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

" set signcolumn=auto:1-3

" set noshowmode

let g:mapleader=" "
let g:maplocalleader=" "

nnoremap <silent> <leader>sa <cmd>w<cr>
inoremap jk <esc>

vnoremap <silent> J <cmd>m '>+1<cr>gv=gv
vnoremap <silent> K <cmd>m '<-2<cr>gv=gv

nnoremap <silent> <leader>sv <cmd>vsplit<cr>
nnoremap <silent> <leader>sh <cmd>split<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>nh <cmd>nohl<cr>

nnoremap <silent> <S-L> <cmd>bnext<cr>
nnoremap <silent> <S-H> <cmd>bprevious<cr>
nnoremap <silent> <leader>bd <cmd>bdelete<cr>

tnoremap <C-n><C-n> <C-\\><C-n>

nnoremap <leader>gg gg=G``

let g:fcitx5state=system("fcitx5-remote")
autocmd InsertLeave * <cmd>silent let g:fcitx5state=system("fcitx5-remote")[0] | silent !fcitx5-remote -c
autocmd InsertEnter * <cmd>silent if fcitx5state==2 | silent !fcitx5-remote -o | endif
