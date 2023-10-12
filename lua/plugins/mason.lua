require('mason').setup({})

require('mason-lspconfig').setup({
    ensure_installed = { "pylsp", "lua_ls", "rust_analyzer", "clangd" },
})

require("mason-null-ls").setup({
    ensure_installed = { "black" }
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
    },
})
