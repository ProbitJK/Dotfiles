local cmp = require("cmp")
local luasnip = require("luasnip")
-- require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
cmp.setup({
    mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<C-e>"] = cmp.mapping.close(),
        -- ["<C-c>"] = cmp.mapping.abort(),
        -- These are apparently a bad idea but somehow <c-n> is not not working for me properly
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }
})
--    completion = {
--        completeopt = "menu, menuone, preview, noselect",
--    },
