--local builtin = require('telescope.builtin')

-- local global_qf = function ()
--     qf = vim.diagnostic.setqflist({ open = false, title = "Major fixes", severity = { min = vim.diagnostic.severity.ERROR } })
-- end
local buff_qf = function()
	local diags = vim.diagnostic.get(
		0,
		{ severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } }
	)
	-- local qfixes = vim.diagnostic.toqflist(diags)
	-- I have no idea how the thing is working without the above line, but if it works it works!
	vim.diagnostic.setqflist(diags)
end

-- Set the diagnostic configuration
vim.diagnostic.config({
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR },
		source = "if_many",
		spacing = 10,
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󱂑",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰋼",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	update_in_insert = false,
	severity_sort = true,
	float = {
		style = "minimal",
		source = "always",
		border = "single",
	},
})

vim.keymap.set("n", "<C-q>", buff_qf, { desc = "Send buffer errors to the quickfix list", remap = false })
vim.keymap.set("n", "<leader>qo", "<cmd>cope<CR>", { desc = "Open quickfix window", remap = false })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix window", remap = false })
vim.keymap.set("n", "<leader>qp", "<cmd>cprevious<CR>", { desc = "Go to previous quickfix item", remap = false })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Go to next quickfix item", remap = false })
vim.keymap.set("n", "<leader>qfp", "<cmd>col<CR>", { desc = "Go to older error list", remap = false })
vim.keymap.set("n", "<leader>qfn", "<cmd>cnew<CR>", { desc = "Go to newer error list", remap = false })
vim.keymap.set("n", "<leader>qfh", "<cmd>chi<CR>", { desc = "Show list of error lists", remap = false })
--vim.keymap.set("n", "<leader>bd", function() builtin.diagnostics({buffer = 0}) end, {desc = 'View all diagnostics for current buffer', remap = false})
--vim.keymap.set("n", "<leader>ld", function() builtin.diagnostics() end, {desc = 'View all diagnostics for all buffer', remap = false})
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end, { desc = "Open current line diagnostics in a floating window", remap = false })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, { desc = "Go to next diagnostic", remap = false })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end, { desc = "Go to previous diagnostic", remap = false })

-- Some keybindings to ensure that looking at somebody else's code does not give me headache from all the warnings and errors
vim.keymap.set("n", "\\dh", function()
	vim.diagnostic.hide()
end, { desc = "Makes all diagnostics disappear", remap = false })
--vim.keymap.set("n", "\\ds", function() vim.diagnostic.show() end, {desc = "Makes all diagnostics appear", remap = false})
