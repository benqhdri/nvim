vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local api = require("nvim-tree.api")
local function opts(desc)
    return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', '<tab>', api.tree.toggle, opts('Toggle'))
vim.keymap.set('n', '<C-f>', function()
    return api.tree.toggle({ find_file = true, focus = true, update_root = true })
end, opts("Find file"))

local function my_on_attach(bufnr)
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- remove defaults
    vim.keymap.del('n', '<tab>', { buffer = bufnr })
    vim.keymap.del('n', 'o', { buffer = bufnr })
    vim.keymap.del('n', 'C', { buffer = bufnr })
    vim.keymap.del('n', '-', { buffer = bufnr })

    -- custom mappings
    vim.keymap.set('n', '?', api.tree.toggle_help, { buffer = bufnr })
    vim.keymap.set('n', 'o', api.node.open.no_window_picker, { buffer = bufnr })
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, { buffer = bufnr })
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, { buffer = bufnr })
    vim.keymap.set('n', 'h', api.node.navigate.parent, { buffer = bufnr })
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    ---
    on_attach = my_on_attach,

    -- change working nvim path
    sync_root_with_cwd = true,
    actions = {
        change_dir = {
            global = true,
        },
    }
}

