local trb = require("trouble")
vim.keymap.set("n", "<leader>df", function () trb.open("document_diagnostics") end, {noremap = true, desc = 'Open diagnostics list for file'})
vim.keymap.set("n", "<leader>dw", function () trb.open("workspace_diagnostics") end, {noremap = true, desc = 'Open diagnostics list for workspace'})
vim.keymap.set("n", "<leader>qf", function () trb.open("quickfix") end, {noremap = true, desc = 'Open quickfix list'})
