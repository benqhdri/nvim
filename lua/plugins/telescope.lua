local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>w', builtin.grep_string, {})
vim.keymap.set('n', '<leader>d', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>p', builtin.pickers, {})

require("telescope").setup({
    defaults = {
        cache_picker = {
            num_pickers = 10
        },
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
            },
        },
    },
})

