require('nvim-treesitter.configs').setup {

  ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "python", "rust" }, 

  highlight = { enable = true },

  indent = { enable = true },
}

