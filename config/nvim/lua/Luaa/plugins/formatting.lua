return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"\\f",
			function()
				require("conform").format({ lsp_fallback = "last", async = false })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "usort", "black" },
			javascript = { "prettierd", stop_after_first = true },
			tex = { "latexindent" },
			markdown = { "prettierd", "cbfmt" },
			json = { "prettierd" },
			cpp = { "clang-format" },
			bib = { "bibtex-tidy" },
		},
		default_format_opts = {
			lsp_format = "fallback",
			timeout_ms = 5000,
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
