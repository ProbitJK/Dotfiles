local builtin = require('telescope.builtin')

-- local global_qf = function ()
--     qf = vim.diagnostic.setqflist({ open = false, title = "Major fixes", severity = { min = vim.diagnostic.severity.ERROR } })
-- end
local buff_qf = function ()
    local diags = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } })
    -- local qfixes = vim.diagnostic.toqflist(diags)
    -- I have no idea how the thing is working without the above line, but if it works it works!
    vim.diagnostic.setqflist(diags)
end

vim.keymap.set("n", "<C-q>", buff_qf, {desc = 'Send buffer errors to the quickfix list', remap = false})
vim.keymap.set("n", "<leader>qo", "<cmd>cope<CR>", {desc = 'Open quickfix window', remap = false})
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", {desc = 'Close quickfix window', remap = false})
vim.keymap.set("n", "<leader>cp", "<cmd>cprevious<CR>", {desc = 'Go to previous quickfix item', remap = false})
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", {desc = 'Go to next quickfix item', remap = false})
vim.keymap.set("n", "<leader>bd", function() builtin.diagnostics({buffer = 0}) end, {desc = 'View all diagnostics for current buffer', remap = false})
vim.keymap.set("n", "<leader>ad", function() builtin.diagnostics() end, {desc = 'View all diagnostics for all buffer', remap = false})
vim.keymap.set("n", "<leader>vd", function () vim.diagnostic.open_float() end, {desc = 'Open current line diagnostics in a floating window', remap = false})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, {desc = "Go to next diagnostic", remap = false})
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, {desc = "Go to previous diagnostic", remap = false})

-- Some keybindings to ensure that looking at somebody else's code does not give me headache from all the warnings and errors
vim.keymap.set("n", "\\dh", function() vim.diagnostic.hide() end, {desc = "Makes all diagnostics disappear", remap = false})
vim.keymap.set("n", "\\ds", function() vim.diagnostic.hide() end, {desc = "Makes all diagnostics appear", remap = false})
