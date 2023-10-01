local dap = require('dap')
local dapui = require('dapui')

dapui.setup()


dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>dc", function() dap.continue() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint() end, {desc = "Start/Continue debugger"})
vim.keymap.set("n", "<leader>dO", function() dap.repl.open() end, {desc = "Start/Continue debugger"})
