function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader>f', builtin.find_files, {})
keymap('n', '<leader>s', builtin.live_grep, {})
keymap('v', '<space>s', function()
    local text = vim.getVisualSelection()
    builtin.live_grep({ default_text = text })
end, opts)
keymap('n', '<leader>w', builtin.grep_string, {})
keymap('n', '<leader>d', builtin.buffers, {})
keymap('n', '<leader>h', builtin.help_tags, {})
keymap('n', '<leader>p', builtin.pickers, {})
keymap('n', '<leader>o', builtin.git_status, {})
keymap('n', '<leader>k', builtin.keymaps, {})
keymap('n', '<leader>m', builtin.man_pages, {})
keymap('n', '<leader>c', builtin.git_bcommits, {})

require('telescope').setup({
    pickers = {
        buffers = {
            initial_mode = "normal",
            mappings = {
                n = {
                    ["d"] = actions.delete_buffer,
                }
            }
        },
        git_bcommits = {
            initial_mode = "normal",
        },
    },
    defaults = {
        cache_picker = {
            num_pickers = 30
        },
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
            },
        },
        initial_mode = "insert",
        mappings = {
            i = {
                ["<C-x>"] = actions.delete_buffer,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-a>"] = actions.select_all,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<C-n>"] = require('telescope.actions').cycle_history_next,
                ["<C-p>"] = require('telescope.actions').cycle_history_prev,
            },
            n = {
                ["<ESC>"] = actions.close,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["o"] = actions.file_edit,
                ["s"] = actions.file_split,
                ["v"] = actions.file_vsplit,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<C-a>"] = actions.select_all,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<C-n>"] = require('telescope.actions').cycle_history_next,
                ["<C-p>"] = require('telescope.actions').cycle_history_prev,
            },
        },
    }
})
