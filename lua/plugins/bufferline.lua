local bl = require("bufferline")
local groups = require("bufferline.groups")
bl.setup {}

local set = vim.keymap.set
local opts = { noremap = true, silent = true, nowait = true }

set("n", "<M-1>", function() bl.go_to(1) end, opts)
set("n", "<M-2>", function() bl.go_to(2) end, opts)
set("n", "<M-3>", function() bl.go_to(3) end, opts)
set("n", "<M-4>", function() bl.go_to(4) end, opts)
set("n", "<M-5>", function() bl.go_to(5) end, opts)
set("n", "<M-6>", function() bl.go_to(6) end, opts)
set("n", "<M-7>", function() bl.go_to(7) end, opts)
set("n", "<M-8>", function() bl.go_to(8) end, opts)
set("n", "<M-9>", function() bl.go_to(9) end, opts)
set("n", "<M-0>", function() bl.go_to(-1) end, opts)

set("n", "<M-j>", function() bl.move_to(1) end, opts)
set("n", "<M-k>", function() bl.move_to(-1) end, opts)
set("n", "<M-P>", function() groups.toggle_pin() end, opts)
set("n", "<leader>Q", function() bl.close_in_direction("right") end, opts)
