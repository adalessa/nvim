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

    use 'sbdchd/neoformat'

    use {
        'neovim/nvim-lspconfig',
        requires = {
            {
                'hrsh7th/nvim-compe',
                config = function()
                    require'compe'.setup {
                        enable = true;
                        autocomplete = true;
                        debug = false;
                        min_lenght = 1;
                        preselect = 'enable';
                        throttle_time = 80;
                        source_timeout = 200;
                        resolve_timeout = 800;
                        incomplete_delay = 400;
                        max_abbr_width = 100;
                        max_kind_width = 100;

                        source = {
                            path = true;
                            buffer = true;
                            calc = true;
                            nvim_lsp = true;
                            nvim_lua = true;
                            vsnip = false;
                            ultisnips = false;
                            luasnip = true;
                        };
                    }
                end
            },
            { 'kabouzeid/nvim-lspinstall' }
        }
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
    use 'EdenEast/nightfox.nvim'

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
