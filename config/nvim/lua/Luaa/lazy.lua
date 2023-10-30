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
    -- plenary, just to be sure
    {
        'nvim-lua/plenary.nvim',
    },
    -- colorscheme: catppuccin
    {
        'catppuccin/nvim',
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    },
    -- Fugitive for git integration
    {
        'tpope/vim-fugitive'
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- Telescope file browser
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim'
        },
    },
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
    },
    -- Harpoon
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- Vimtex for latex integration
    --{
    --    'lervag/vimtex',
    --},
    -- Icons to show on the sideline
    {
        'nvim-tree/nvim-web-devicons',
    },
    -- Status line provided by lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- get buffer completion
    {
        'hrsh7th/cmp-buffer',
    },
    -- Path completion
    {
        'hrsh7th/cmp-path',
    },
    -- LuaSnip for snippets
    {
        'L3MON4D3/LuaSnip',
    },
    -- To make LuaSnip work smoothly with nvim-cmp
    {
        'saadparwaiz1/cmp_luasnip',
    },
    -- To get lsp completions in nvim-cmp
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    -- Completion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
    },
    -- Mason for installing stuff
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
    },
    -- LSP stuff
    {
        'neovim/nvim-lspconfig',
        event = {
            'BufReadPre',
            'BufNewFile',
        },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
    },
    -- Debugger
    {
        'mfussenegger/nvim-dap',
    },
    -- Debugger UI
    {
        'rcarriga/nvim-dap-ui',
        event = 'VeryLazy',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
    -- Python debugger
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            local path = "~/.virtualenvs/debugpy/bin/python"
            require("dap-python").setup(path)
        end,
    },
    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    },
    -- Formatting
    {
        "stevearc/conform.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    },
})
