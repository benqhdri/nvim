local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- only for current buffer
local opts = { noremap = true, silent = true, nowait = true, buffer = true }
local auto_write = augroup('AutoWrite', {})

autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = auto_write,
    pattern = '*.*',
    callback = function()
        vim.cmd('silent write')
    end,
})

autocmd({ 'TermOpen' }, {
    callback = function()
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.buflisted = false
        vim.cmd('startinsert')
        vim.keymap.set({ "n", "v" }, "<C-\\>", "<C-\\><C-N>:b#<CR>", opts)
    end,
})

autocmd({ 'BufWinEnter', 'WinEnter' }, {
    pattern = 'term://*',
    callback = function()
        vim.cmd('startinsert')
    end,
})

autocmd({ 'BufWinLeave', 'WinLeave' }, {
    pattern = 'term://*',
    callback = function()
        vim.cmd('stopinsert')
    end,
})

autocmd({ 'BufEnter' }, {
    pattern = 'NvimTree*',
    callback = function()
        vim.cmd('stopinsert')
    end,
})

-- Bypass ass file slow problem
autocmd({ 'BufEnter' }, {
    pattern = '*.ass',
    callback = function()
        vim.opt_local.syntax = "off"
    end,
})
