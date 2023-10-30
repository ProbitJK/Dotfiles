local lint = require("lint")

lint.linters_by_ft = {
    python = { "pylint", "pydocstyle" },
    text = { "proselint" },
    markdown = { "proselint" },
    latex = { "proselint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd(
{
    "BufEnter",
    "BufWritePost",
    "InsertLeave"
},
{
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

-- force linting
vim.keymap.set("n", "\\l", function()
    lint.try_lint()
end, { desc = "Trigger file linting", remap = false })
