return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    -- Theme
    use('ellisonleao/gruvbox.nvim')

    -- Nvim-tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Harpoon
    use("ThePrimeagen/harpoon")

    -- Git
    use('lewis6991/gitsigns.nvim')

    -- Align
    use('echasnovski/mini.align')

    -- BufferLine
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Package manage
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            -- Formatter
            { 'jay-babu/mason-null-ls.nvim' },
            { 'jose-elias-alvarez/null-ls.nvim' }
        }
    }
end)
