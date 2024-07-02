return{
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        opts = {
            show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
            debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
            disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
            language = "English" -- Copilot answer language settings when using default prompts. Default language is English.
        },
        build = function()
            vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
        end,
        event = "VeryLazy",
        dependencies = {
            "github/copilot.vim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "Open CopilotChat" },
            {
                "<leader>ct",
                "<cmd>CopilotChatToggle<cr>",
                desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
            },
            {
                "<leader>cfix",
                "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
                desc = "CopilotChat - Fix diagnostic",
            },
            {
                "<leader>cci",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
        --[[
            { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
        --]]
        },
    },
}
