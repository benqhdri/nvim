local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>w', builtin.grep_string, {})
vim.keymap.set('n', '<leader>d', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>p', builtin.pickers, {})
vim.keymap.set('n', '<leader>o', builtin.git_status, {})
vim.keymap.set('n', '<leader>k', builtin.keymaps, {})

local telescope_custom_actions = {}
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end

function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "split")
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

require('telescope').setup({
    defaults = {
        cache_picker = {
            num_pickers = 30
        },
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
            },
        },

        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-x>"] = actions.delete_buffer,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<leader>a"] = actions.select_all,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<enter>"] = telescope_custom_actions.multi_selection_open,
                ["<C-n>"] = require('telescope.actions').cycle_history_next,
                ["<C-p>"] = require('telescope.actions').cycle_history_prev,
            },
        },

    }
})

-- require("telescope").setup({
--     defaults = {
--         cache_picker = {
--             num_pickers = 30
--         },
--         layout_config = {
--             horizontal = {
--                 preview_cutoff = 0,
--             },
--         },
--
--         mappings = {
--             n = {
--                 ["o"] = "file_edit",
--                 ["v"] = "select_vertical",
--                 ["<C-u>"] = "results_scrolling_up",
--                 ["<C-d>"] = "results_scrolling_down",
--                 ["d"] = "delete_buffer",
--                 ["<C-a>"] = "select_all",
--                 ["<Esc>"] = "drop_all",
--             },
--             i = {
--                 ["<C-a>"] = "toggle_all",
--                 ["<C-u>"] = "results_scrolling_up",
--                 ["<C-d>"] = "results_scrolling_down",
--             },
--         },
--     },
-- })
