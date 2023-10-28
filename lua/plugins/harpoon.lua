local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>w", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>j", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>k", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>u", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>i", function() ui.nav_file(5) end)

vim.keymap.set("n", "<leader>;", function() term.gotoTerminal(1) end)
