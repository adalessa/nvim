vim.cmd [[packadd packer.nvim]]
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'ThePrimeagen/refactoring.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-refactor' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    use {
        'ThePrimeagen/harpoon',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'ThePrimeagen/harpoon',
        },
    }

    use {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup {
                context = 3,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                    "function_declaration",
                    "function_call_expression",
                    "expression_statement",
                    "function",
                    "function_definition",
                    "method_declaration",
                    "method",
                    "table",
                    "if_statement",
                    "type_declaration",
                },
            }
        end
    }

    use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"
    use "onsails/lspkind-nvim"

    use "tjdevries/colorbuddy.nvim"

    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }

    use 'L3MON4D3/LuaSnip'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim'},
            { 'nvim-lua/popup.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'kyazdani42/nvim-web-devicons' }
        }
    }

    use 'hoob3rt/lualine.nvim'

    use {
        'puremourning/vimspector',
        requires = {
            { 'mfussenegger/nvim-dap' }
        },
        fn = "vimspector#Launch",
    }

    use 'szw/vim-maximizer'

    use 'vim-test/vim-test'

    use 'fatih/vim-go'

    use {
        'noahfrederick/vim-laravel',
        requires = {
            { 'tpope/vim-projectionist' },
            { 'noahfrederick/vim-composer' }
        }
    }

    use 'jwalton512/vim-blade'
    use 'fladson/vim-kitty'

    use 'gruvbox-community/gruvbox'
    use 'EdenEast/nightfox.nvim'
    use {
        'frenzyexists/aquarium-vim', branch = 'develop'
    }


    use 'Raimondi/delimitMate'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-obsession'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-commentary'
    use 'tpope/vim-tbone'
    use 'tpope/vim-dadbod'
    use 'airblade/vim-gitgutter'
    use 'hashivim/vim-terraform'
    use 'mattn/emmet-vim'

    use { 'nicwest/vim-http', opt = true, cmd = {'Http'}}

    use { 'vimwiki/vimwiki', opt = true, cmd = {'VimwikiIndex'}}

end)
