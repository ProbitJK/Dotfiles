local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        python = {
            "isort",
            "black",
        },
        -- for some reason latexindent does not fucking work
        --latex = { "latexindent" },
        markdown = { "prettier" },
        json = { "prettier" },
    },
})

vim.keymap.set({"n", "v"}, "\\f", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file", remap = false})
