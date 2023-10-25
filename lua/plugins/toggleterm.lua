require("toggleterm").setup({
    direction = 'vertical',
    open_mapping = [[<c-\>]],
    size = 90,
    shade_terminals = true,
    start_in_insert = true,
    persist_mode = false,
    close_on_exit = true,
    auto_scroll = true,
    hide_numbers = false,
}
)

local set = vim.keymap.set
local opts = { noremap = true, silent = true, nowait = true }

set('x', '<CR>', [[:'<,'>ToggleTermSendVisualSelection<CR>]], opts)
set('n', '<S-Enter>', [[:ToggleTermSendCurrentLine<CR>]], opts)
