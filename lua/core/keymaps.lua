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

-- Map H and L to ^ and $h(skip the extra space on the end)
-- Map with normal mode, operator-pending mode and visual mode
set({ "n", "o", "x" }, "H", "^")
set("n", "L", "$")
set({ "o", "x" }, "L", "$h")

-- Windows operations
set({ "n", "x" }, "<C-h>", "<C-w>h", opts)
set({ "n", "x" }, "<C-j>", "<C-w>j", opts)
set({ "n", "x" }, "<C-k>", "<C-w>k", opts)
set({ "n", "x" }, "<C-l>", "<C-w>l", opts)
set({ "t", "i" }, "<C-h>", "<C-\\><C-N><C-w>h", opts)
set({ "t", "i" }, "<C-j>", "<C-\\><C-N><C-w>j", opts)
set({ "t", "i" }, "<C-k>", "<C-\\><C-N><C-w>k", opts)
set({ "t", "i" }, "<C-l>", "<C-\\><C-N><C-w>l", opts)
set("n", "<C-c>", "<C-w>c", opts)
set("n", "<A-c>", ":vs#<CR>", opts)
set("t", "<C-\\>", "<C-\\><C-N>:b#<CR>", opts)

-- No highlight
set({ "n", "v", "i" }, "<Esc>", "<Esc>:nohlsearch<CR>", opts)
