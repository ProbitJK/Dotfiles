-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  -- or                            , tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
	  "catppuccin/nvim",
	  as = "catppuccin",
	  config = function()
		  vim.cmd('colorscheme catppuccin')
	  end
  }
  use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use ( 'tpope/vim-fugitive' )
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }
  use ( 'lervag/vimtex' )
  use ( 'nvim-tree/nvim-web-devicons' )
  use {
      "nvim-lualine/lualine.nvim",
      opt = false,
      requires = { "nvim-web-devicons" }
  }
  use ( 'nanozuki/tabby.nvim' )
  use {
      'startup-nvim/startup.nvim',
      config = function()
          require'startup'.setup(require"LuLuLuLUA.startup_nvim")
      end
  }
  use {
      'vimwiki/vimwiki',
      config = function()
          vim.cmd([[
          let g:vimwiki_list = [{'path': '~/PhD_work/Notes/', 'syntax': 'markdown', 'ext': '.md'}]
          let g:vimwiki_global_ext = 0
          ]])
      end
  }
end)
