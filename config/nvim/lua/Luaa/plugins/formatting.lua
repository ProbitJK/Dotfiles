return {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = {
                    "isort",
                    "black",
                },
                latex = { "latexindent" },
                markdown = { "prettier" },
                json = { "prettier" },
                cpp = { "clang-format" },
            },
        })

        vim.keymap.set({ "n", "v" }, "\\f", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file", remap = false })
    end
}
