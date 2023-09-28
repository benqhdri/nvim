local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = args.buf })
    end,
})


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "pylsp", "lua_ls", "rust_analyzer", "clangd" },
    handlers = {
        lsp_zero.default_setup,
    },
})
