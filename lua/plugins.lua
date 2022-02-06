vim.cmd [[packadd packer.nvim]]
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}

    use {
        'ThePrimeagen/refactoring.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    }

    use {
        'ThePrimeagen/harpoon',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
    }

    use 'tpope/vim-dispatch'

    -- Completition
    use {
        "hrsh7th/nvim-cmp",
        requires = {
             "hrsh7th/cmp-buffer",
             "hrsh7th/cmp-path",
             "hrsh7th/cmp-nvim-lua",
             "hrsh7th/cmp-nvim-lsp",
             "saadparwaiz1/cmp_luasnip",
             "onsails/lspkind-nvim",
            "L3MON4D3/LuaSnip",
        }
    }

    use "windwp/nvim-autopairs"

    use "tjdevries/colorbuddy.nvim"

    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'ray-x/lsp_signature.nvim'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim'},
            { 'nvim-lua/popup.nvim' },
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-file-browser.nvim' }
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
        'leoluz/nvim-dap-go',
        requires = {
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap',
            "Pocco81/DAPInstall.nvim",
            'leoluz/nvim-dap-go',
        }
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

    use 'dracula/vim'

    use 'Raimondi/delimitMate'
    use 'tpope/vim-surround'
    use 'tpope/vim-dotenv'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-obsession'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-commentary'

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }

    use 'tpope/vim-tbone'

    use {
        'tpope/vim-dadbod',
        requires = {
           'kristijanhusak/vim-dadbod-ui',
        }
    }

    use { 'nicwest/vim-http', opt = true, cmd = {'Http'}}
    use { 'vimwiki/vimwiki', opt = true, cmd = {'VimwikiIndex'}}

    -- Local plugins can be included
    use '~/code/neovim/telescope-projectionist.nvim'
end)
