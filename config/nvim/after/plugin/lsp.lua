local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    opts.buffer = bufnr

    opts.desc = "Jump to definition"
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

    opts.desc = "Jump to declaration"  -- not supported by many LSPs
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)

    opts.desc = "List all implementation in quickfix window"  -- not hugely supported
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)

    opts.desc = "Display information about symbol in a hovering window"
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    opts.desc = "Display signature information about symbol"
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    opts.desc = "Code actions! Hee-Haw"
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

    opts.desc = "List all references to symbol"
    vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)

    opts.desc = "Rename symbol"
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setting up servers
-- pylsp for Python
lspconfig.pylsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "python" },
}
-- lua_ls for Lua
lspconfig.lua_ls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- clangd for C/C++/Rust
lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- fortls for Fortran
lspconfig.fortls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- grammarly for english checking
lspconfig.grammarly.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "markdown", "text", "tex" },
}
-- texlab for LaTeX
lspconfig.texlab.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- marksman for markdown
lspconfig.marksman.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
-- jsonls for JSON files
lspconfig.jsonls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
