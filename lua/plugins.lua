vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use {
        'ThePrimeagen/refactoring.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    }


    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }

    use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    use 'sbdchd/neoformat'

    use {
        'neovim/nvim-lspconfig',
        requires = {
            { 'hrsh7th/nvim-compe' },
            { 'anott03/nvim-lspinstall' }
        }
    }

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
    use 'fladson/vim-kitty'

    use 'gruvbox-community/gruvbox'

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
