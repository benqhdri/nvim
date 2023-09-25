vim.g.mapleader = " "
local set = vim.keymap.set
local opts = { noremap = true, silent = true, nowait = true }

-- Yank
set("x", "p", "pgvy", opts)
-- Run command
set("n", "R", "y$pa<CR>", opts)

-- Autocomplete in command line mode
set("c", "<C-p>", "<Up>")
set("c", "<C-n>", "<Down>")

-- Buffer operations
set("n", "<C-p>", ":bp<CR>", opts)
set("n", "<C-n>", ":bn<CR>", opts)
set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts)
set("n", "<leader>Q", "[[:%bd|e#<CR>]]", opts)

-- Windows operations
set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-l>", "<C-w>l", opts)
set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
set("i", "<C-h>", "<C-\\><C-N><C-w>h", opts)
set("i", "<C-j>", "<C-\\><C-N><C-w>j", opts)
set("i", "<C-k>", "<C-\\><C-N><C-w>k", opts)
set("i", "<C-l>", "<C-\\><C-N><C-w>l", opts)
set("n", "<C-c>", "<C-w>c", opts)
set("n", "<A-c>", ":vs#<CR>", opts)
set("n", "Q", ":only<CR>", opts)
set("t", "Q", ":only<CR>", opts)

-- No highlight
set("n", "<Esc>", "<Esc>:nohlsearch<CR>", opts)
set("v", "<Esc>", "<Esc>:nohlsearch<CR>", opts)
set("i", "<Esc>", "<Esc>:nohlsearch<CR>", opts)

