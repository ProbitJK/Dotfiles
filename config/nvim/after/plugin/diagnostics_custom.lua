local builtin = require('telescope.builtin')

-- local global_qf = function ()
--     qf = vim.diagnostic.setqflist({ open = false, title = "Major fixes", severity = { min = vim.diagnostic.severity.ERROR } })
-- end
local buff_qf = function ()
    local diags = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
    -- local qfixes = vim.diagnostic.toqflist(diags)
    -- I have no idea how the thing is working without the above line, but if it works it works!
    vim.diagnostic.setqflist(diags)
end

vim.keymap.set("n", "<C-q>", buff_qf, {desc = 'Send buffer errors to the quickfix list', remap = false})
vim.keymap.set("n", "<leader>qf", "<cmd>cw<CR>", {desc = 'Open quickfix window', remap = false})
vim.keymap.set("n", "<leader>bd", function() builtin.diagnostics({buffer = 0}) end, {desc = 'View all diagnostics for current buffer', remap = false})
vim.keymap.set("n", "<leader>ad", function() builtin.diagnostics() end, {desc = 'View all diagnostics for all buffer', remap = false})
vim.keymap.set("n", "<leader>vd", function () vim.diagnostic.open_float() end, {desc = 'Open current line diagnostics in a floating window', remap = false})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, {desc = "Go to next diagnostic", remap = false})
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, {desc = "Go to previous diagnostic", remap = false})
