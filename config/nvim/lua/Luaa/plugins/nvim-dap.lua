return {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    config = function()
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

        vim.keymap.set("n", "<leader>dc", function() dap.continue() end,
            { desc = "Start/Continue debugger", remap = false })
        vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, { desc = "Step over function", remap = false })
        vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step into function", remap = false })
        vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step out of function", remap = false })
        vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end,
            { desc = "Toggle breakpoint", remap = false })
        --vim.keymap.set("n", "<leader>dO", function() dap.repl.open() end, {desc = "Open REPL", remap = false})
        vim.keymap.set("n", "<leader>dO", function() dapui.toggle() end, { desc = "Toggle UI", remap = false })
        vim.keymap.set("n", "<leader>dT", function() dapui.terminate() end,
            { desc = "Terminate debug session", remap = false })
    end
}
