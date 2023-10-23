require("core.keymaps")
require("core.options")
require("plugins/packer")
require("plugins/lualine")
require("plugins/nvim_tree")
require("plugins/telescope")
require("plugins/lspconfig")
require("plugins/gitsigns")
require("plugins/mason")
require("plugins/gruvbox")
require("plugins/toggleterm")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local auto_write = augroup('AutoWrite', {})

autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = auto_write,
    pattern = '*.*',
    callback = function()
        vim.cmd('silent write')
    end,
})
