local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    -- jump back into last snippet even if we have moved outside of the selection
    history = true,
    -- Update dynamic snippets as we type
    updateevents = "TextChanged, TextChangedI",
    -- Autosnippets
    enable_autosnippets = true,
}

vim.keymap.set({"i", "s"}, "<C-j>", function ()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-k>", function ()
    if ls.jumpable(-1) then
        ls.expand_or_jump()
    end
end, {silent = true})
vim.keymap.set("i", "<C-l>", function ()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)
