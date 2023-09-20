return require('packer').startup(function(use)
    -- Packer itself
    use 'wbthomason/packer.nvim'
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Telescope file browser
    use 'nvim-telescope/telescope-file-browser.nvim'
    -- Tree-sitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    -- LSP-Zero to provide lsp support
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' },   -- Optional
            { 'hrsh7th/cmp-path' },     -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }
    -- Git integration
    use('tpope/vim-fugitive')
    -- Harpoon baby
    use('theprimeagen/harpoon')
    -- 'cuz I love latex
    use('lervag/vimtex')
    -- vimwiki for note-taking
    -- use {
    --     'vimwiki/vimwiki',
    --     config = function()
    --         vim.g.vimwiki_list = {
    --             {
    --                 path = '~/PhD_work/Notes/',
    --                 syntax = 'markdown',
    --                 ext = '.md',
    --             }
    --         }
    --         vim.g.vimwiki_global_ext = 0
    --     end
    -- }
    -- Colorscheme catppuccin
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    }
    -- sexy icons
    use('nvim-tree/nvim-web-devicons')
    -- statusline
    use {
        "nvim-lualine/lualine.nvim",
        opt = false,
    }
    -- I have given up on trying to figure out how to make diagnostics work by myself
    use 'folke/trouble.nvim'
    -- Faster commenting
    use 'numToStr/Comment.nvim'
end)
