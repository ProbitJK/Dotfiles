local null_ls = require("null-ls")

local code_actions = null_ls.builtins.code_actions

local diagnostics = null_ls.builtins.diagnostics

local formatting = null_ls.builtins.formatting

local hover = null_ls.builtins.hover

local completion = null_ls.builtins.completion

null_ls.setup({
    sources = {
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.proselint,
    null_ls.builtins.diagnostics.pydocstyle,
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.latexindent,
    null_ls.builtins.formatting.markdownlint
    },
})
