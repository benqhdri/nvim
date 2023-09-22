require("core.keymaps")
require("core.options")
require("plugins/plugins-setup")
require("plugins/lualine")
require("plugins/navigation")
require("plugins/highlight")
require("plugins/telescope")
require("plugins/lsp")
require("plugins/rust-lang")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local auto_write = augroup('AutoWrite', {})

autocmd({'TextChanged', 'TextChangedI'}, {
    group = auto_write,
    pattern = '*.*',
    callback = function()
        vim.cmd('silent write')
    end,
})

