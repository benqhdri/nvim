require("core.keymaps")
require("core.options")
require("core.autocmds")

local set = vim.keymap.set
local del = vim.keymap.del
local opts = { noremap = true, silent = true, nowait = true }
local all_mods = { "n", "t", "v", "i" }
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            local api = require("nvim-tree.api")

            set({ 'n', 't', 'x' }, '<C-;>', api.tree.toggle, opts)
            set({ 'n', 'x' }, '<C-f>', function()
                return api.tree.open({ find_file = true, update_root = true })
            end, opts)

            local function my_on_attach(bufnr)
                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- remove defaults
                del('n', 'O', { buffer = bufnr })
                del('n', 'o', { buffer = bufnr })
                del('n', 'C', { buffer = bufnr })
                del('n', '-', { buffer = bufnr })

                -- custom mappings
                set('n', '?', api.tree.toggle_help, { buffer = bufnr })
                set('n', 'O', function()
                    api.node.open.no_window_picker()
                    api.tree.focus()
                end, { buffer = bufnr })
                set('n', 'o', api.node.open.no_window_picker, { buffer = bufnr })
                set('n', 'C', api.tree.change_root_to_node, { buffer = bufnr })
                set('n', 'u', api.tree.change_root_to_parent, { buffer = bufnr })
                set('n', 'h', api.node.navigate.parent, { buffer = bufnr })
                set('n', '<C-f>', api.tree.toggle, { buffer = bufnr })
            end

            require("nvim-tree").setup {
                on_attach = my_on_attach,

                sync_root_with_cwd = true,
                actions = {
                    change_dir = {
                        global = true,
                    },
                },
                view = {
                    preserve_window_proportions = true,
                }
            }
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'akinsho/bufferline.nvim',
        config = function()
            local bl = require("bufferline")
            local groups = require("bufferline.groups")
            bl.setup {}
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

            set({ "n", "v" }, "<C-n>", function() bl.cycle(-1) end, opts)
            set({ "n", "v" }, "<C-p>", function() bl.cycle(1) end, opts)
            set(all_mods, "<M-J>", function() bl.move(-1) end, opts)
            set(all_mods, "<M-K>", function() bl.move(1) end, opts)
            set(all_mods, "<M-P>", function() groups.toggle_pin() end, opts)
        end
    },
    {
        'ojroques/nvim-bufdel',
        config = function()
            require("bufdel").setup {
                quit = false,
            }
            set({ "n", "v" }, "<leader>q", ":BufDel<CR>", opts)
            set({ "n", "v" }, "<leader>Q", ":BufDelOthers<CR>", opts)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
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

            set('n', '<leader>f', builtin.find_files, {})
            set('n', '<leader>s', builtin.live_grep, {})
            set('v', '<space>s', function()
                local text = vim.getVisualSelection()
                builtin.live_grep({ default_text = text })
            end, opts)
            set('n', '<leader>w', builtin.grep_string, {})
            set('n', '<leader>d', builtin.buffers, {})
            set('n', '<leader>h', builtin.help_tags, {})
            set('n', '<leader>o', builtin.git_status, {})
            set('n', '<leader>k', builtin.keymaps, {})
            set('n', '<leader>M', builtin.man_pages, {})
            set('n', '<leader>m', builtin.marks, {})
            set('n', '<leader>c', builtin.git_bcommits, {})
            set('n', '<leader>ls', builtin.lsp_document_symbols, {})
            set('n', '<leader>lS', builtin.lsp_workspace_symbols, {})
            set('n', 'gr', builtin.lsp_references, {})

            require('telescope').setup({
                pickers = {
                    buffers = {
                        mappings = {
                            n = {
                                ["d"] = actions.delete_buffer,
                            }
                        }
                    },
                    grep_string = {
                        initial_mode = "normal",
                    },
                    git_bcommits = {
                        initial_mode = "normal",
                    },
                    git_status = {
                        initial_mode = "normal",
                    },
                    marks = {
                        initial_mode = "normal",
                    },
                    lsp_references = {
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
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-a>"] = actions.select_all,
                            ["<C-u>"] = actions.move_selection_previous + actions.move_selection_previous +
                                actions.move_selection_previous + actions.move_selection_previous +
                                actions.move_selection_previous,
                            ["<C-d>"] = actions.move_selection_next + actions.move_selection_next +
                                actions.move_selection_next + actions.move_selection_next + actions.move_selection_next,
                            ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                            ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                            ["<C-n>"] = require('telescope.actions').cycle_history_next,
                            ["<C-p>"] = require('telescope.actions').cycle_history_prev,
                        },
                        n = {
                            ["<ESC>"] = actions.close,
                            ["q"] = actions.close,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["o"] = actions.file_edit,
                            ["s"] = actions.file_split,
                            ["v"] = actions.file_vsplit,
                            ["u"] = actions.move_selection_previous + actions.move_selection_previous +
                                actions.move_selection_previous + actions.move_selection_previous +
                                actions.move_selection_previous,
                            ["d"] = actions.move_selection_next + actions.move_selection_next +
                                actions.move_selection_next + actions.move_selection_next + actions.move_selection_next,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<C-a>"] = actions.select_all,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                            ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                            ["<C-n>"] = require('telescope.actions').cycle_history_next,
                            ["<C-p>"] = require('telescope.actions').cycle_history_prev,
                        },
                    },
                }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = "onelight"
                },
                sections = {
                    lualine_b = {
                        {
                            'branch',
                            color = { fg = '#af0000' },
                        },
                    },
                },
            })
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- Actions
                    map('n', '<leader>gp', gs.preview_hunk)
                    map('n', '<leader>gb', function() gs.blame_line { full = true } end)
                    map('n', '<leader>gd', gs.diffthis)
                    map('n', '<leader>gD', function() gs.diffthis('~') end)
                    map('n', '<leader>gu', gs.reset_hunk)
                    map('n', '<leader>gU', gs.reset_buffer)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    },
    {
        'echasnovski/mini.align',
        config = function()
            require('mini.align').setup()
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Package manage
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            -- Formatter
            { 'jay-babu/mason-null-ls.nvim' },
            { 'jose-elias-alvarez/null-ls.nvim' }
        },
        config = function()
            require('mason').setup({})

            require('mason-lspconfig').setup({
                ensure_installed = { "pyright", "lua_ls", "rust_analyzer", "clangd", "bashls" },
            })

            require("mason-null-ls").setup({
                ensure_installed = { "black", "jq", "beautysh" }
            })

            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.beautysh,
                    null_ls.builtins.formatting.jq.with({
                        extra_args = { "--indent", "4" }
                    }),
                },
            })

            local lspconfig = require('lspconfig')
            lspconfig.pyright.setup {}
            lspconfig.tsserver.setup {}
            lspconfig.clangd.setup {}
            lspconfig.bashls.setup {}

            -- Lua
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                    },
                },
            }

            -- Rust
            lspconfig.rust_analyzer.setup {
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ['rust-analyzer'] = {
                        cargo = { allFeatures = true }
                    },
                },
            }

            -- Diagnostics
            set('n', '<F4>', function()
                if vim.diagnostic.is_disabled() then
                    vim.diagnostic.enable()
                else
                    vim.diagnostic.disable()
                end
            end)
            set('n', '[d', vim.diagnostic.goto_prev)
            set('n', ']d', vim.diagnostic.goto_next)

            -- Lsp mappings
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Disable lsp to change code color
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil

                    local opts = { buffer = ev.buf }
                    set('n', 'gd', vim.lsp.buf.definition, opts)
                    set('n', '<leader>lk', vim.lsp.buf.hover, opts)
                    set('n', '<leader>la', vim.lsp.buf.code_action, opts)
                    set('n', '<leader>lf', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },
    {
        'ThePrimeagen/harpoon',
        config = function()
            local term = require("harpoon.term")
            set("n", "<C-\\>", function() term.gotoTerminal(1) end)
            set("n", "<C-/>", function() term.gotoTerminal(2) end)
        end
    },
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require('blame').setup({
                date_format = "%Y/%m/%d",
            })
            set("n", "t", function()
                vim.cmd("ToggleBlame")
                vim.opt.cursorline = false
            end, opts)
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
})
