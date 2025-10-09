return {
	"neovim/nvim-lspconfig",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		mason.setup()
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"fortls",
				"lua_ls",
				"ltex",
				"marksman",
				"basedpyright",
				"texlab",
			},
			automatic_installation = true,
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["ltex"] = function()
					lspconfig.ltex.setup({
						capabilities = capabilities,
						filetypes = { "text", "plaintext", "tex", "markdown" },
						settings = {
							ltex = {
								language = "en",
								spellcheck = true,
								grammarly = true,
							},
						},
					})
				end,
			},
		})
	end,
}
