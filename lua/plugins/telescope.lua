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
local telescope_custom_actions = {}
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
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
    pickers = {
        find_files = {
            initial_mode = "insert",
        },
        buffers = {
            mappings = {
                n = {
                    ["d"] = actions.delete_buffer,
                }
            }
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
        initial_mode = "normal",
        mappings = {
            i = {
                ["<C-x>"] = actions.delete_buffer,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<leader>a"] = actions.select_all,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<enter>"] = telescope_custom_actions.multi_selection_open,
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
                ["u"] = actions.results_scrolling_up,
                ["d"] = actions.results_scrolling_down,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
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
