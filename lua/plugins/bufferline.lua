local bl = require("bufferline")
local groups = require("bufferline.groups")
bl.setup {}

local set = vim.keymap.set
local opts = { noremap = true, silent = true, nowait = true }
local all_mods = { "n", "t", "v", "i" }

set(all_mods, "<M-1>", function() bl.go_to(1) end, opts)
set(all_mods, "<M-2>", function() bl.go_to(2) end, opts)
set(all_mods, "<M-3>", function() bl.go_to(3) end, opts)
set(all_mods, "<M-4>", function() bl.go_to(4) end, opts)
set(all_mods, "<M-5>", function() bl.go_to(5) end, opts)
set(all_mods, "<M-6>", function() bl.go_to(6) end, opts)
set(all_mods, "<M-7>", function() bl.go_to(7) end, opts)
set(all_mods, "<M-8>", function() bl.go_to(8) end, opts)
set(all_mods, "<M-9>", function() bl.go_to(9) end, opts)
set(all_mods, "<M-0>", function() bl.go_to(-1) end, opts)

set(all_mods, "<M-j>", function() bl.cycle(-1) end, opts)
set(all_mods, "<M-k>", function() bl.cycle(1) end, opts)
set(all_mods, "<M-J>", function() bl.move(-1) end, opts)
set(all_mods, "<M-K>", function() bl.move(1) end, opts)
set(all_mods, "<M-P>", function() groups.toggle_pin() end, opts)
set({ "n", "v" }, "<leader>q", function() bl.unpin_and_close() end, opts)
set({ "n", "v" }, "<leader>Q", function() bl.close_in_direction("right") end, opts)
