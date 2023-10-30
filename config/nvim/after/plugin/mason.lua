local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "clangd",
        "fortls",
        "lua_ls",
        "ltex",
        "marksman",
        "pylsp",
        "texlab",
    },
    automatic_installation = true,
})
