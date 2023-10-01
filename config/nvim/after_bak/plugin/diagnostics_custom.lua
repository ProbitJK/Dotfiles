local global_qf = function ()
    qf = vim.diagnostic.setqflist({ open = false, title = "Major fixes", severity = { min = vim.diagnostic.severity.ERROR } })
end
local buff_qf = function ()
    diags = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
    qfixes = vim.diagnostic.toqflist(diags)
    qf = vim.diagnostic.setqflist(qfixes)
end

vim.keymap.set("n", "\\ds", vim.diagnostic.show, {buffer = 0, desc = 'Show diagnostics in the buffer'})
vim.keymap.set("n", "\\dh", vim.diagnostic.hide, {buffer = 0, desc = 'Hide diagnostics in the buffer'})
vim.keymap.set("n", "\\bq", buff_qf, {desc = 'Send buffer errors to the quickfix list'})
